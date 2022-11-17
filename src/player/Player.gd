extends Actor

#
# Node/Scene references
#
onready var current_world = self.get_parent()

## Sound
onready var jump_snd = $Sound/Jump1
onready var double_jump_snd = $Sound/Jump2
onready var hurt_snd = $Sound/Hurt
onready var step_snd = $Sound/Step
onready var death_snd = $Sound/Death
onready var victory_snd = $Sound/Victory

## Particles
onready var jump_fx = $Effects/Jump
onready var death_fx = $Effects/Death
onready var victory_fx = $Effects/Victory

## Game Over
onready var game_over_text = $GameOver/Label
onready var game_over = $GameOver
onready var retry_btn = $GameOver/Retry
onready var quit_btn = $GameOver/Quit

## Misc
onready var anim = $AnimationPlayer
onready var sprite = $Sprite

#
# Variables
#

## Movement
var velocity := Vector2.ZERO
var launch_vector := Vector2()

## Misc
var is_alive = true

## Step Sound
# True = Higher pitched
# False = Lower pitched
var step = true


func _ready():
	EventBus.connect("level_complete", self, "_on_Level_Complete")


func _physics_process(delta: float) -> void:
	var sprite_flash_mod = sprite.material.get_shader_param("flash_mod")
	if sprite_flash_mod > 0.0:
		sprite.material.set_shader_param("flash_mod", lerp(sprite_flash_mod, 0.0, 0.5))
	
	
	if !is_alive:
		return
	
	##
	## Player Movement
	##
	var horizontal_direction = (
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	
	velocity.x = horizontal_direction * _move_speed
	
	velocity.y += gravity
	
	#
	# Get some key info about the player
	# Can clean up late but for now this stays
	#
	var is_falling  		:= velocity.y > 0.0 && not is_on_floor()
	var is_jumping  		:= Input.is_action_just_pressed("move_jump") && is_on_floor()
	var is_double_jumping	:= Input.is_action_just_pressed("move_jump") && is_falling
	var is_jump_cancelled	:= Input.is_action_just_released("move_jump") && velocity.y < 0.0
	var is_idling			:= is_on_floor() && is_zero_approx(velocity.x)
	var is_moving			:= is_on_floor() && not is_zero_approx(velocity.x)
	
	##
	## Jumping
	##
	if is_jumping:
		_jumps_made += 1
		velocity.y = -_jump_force
		jump_snd.play()
	elif is_double_jumping:
		_jumps_made += 1
		if _jumps_made <= _max_jumps:
			velocity.y = -(_jump_force * 0.75)
			double_jump_snd.play()
			jump_fx.emitting = true
	elif is_jump_cancelled:
		velocity.y = lerp(velocity.y, 0.0, 0.35)
	elif is_idling || is_moving:
		velocity.y = 1
		_jumps_made = 0
	
	##
	## Animations
	##
	if horizontal_direction < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	if is_falling:
		anim.play("jump")
	elif is_moving:
		anim.play("move")
	else:
		anim.play("RESET")
	
	if launch_vector != Vector2.ZERO:
		velocity.y = launch_vector.y
		launch_vector = Vector2.ZERO
	
	move_and_slide(velocity, Vector2.UP)
	
	var slide_collision = get_last_slide_collision()
	
	if slide_collision && slide_collision.collider.is_in_group("EndofLevel"):
		EventBus.emit_signal("level_complete")
		print("Complete?")
	
	if slide_collision && slide_collision.collider.is_in_group("hazard"):
		EventBus.emit_signal("player_hurt", 1)
		if !is_alive:
			return
		hurt_snd.play()
		sprite.material.set_shader_param("flash_mod", 1.0)
		launch_vector = self.global_position.direction_to(slide_collision.collider.global_position) * -1000

func _on_Level_Complete():
	is_alive = false
	victory_snd.play()
	victory_fx.emitting = true
	
	_show_game_over("You Won!")

func _kill_player():
	is_alive = false
	
	EventBus.emit_signal("player_killed")
	
	death_fx.emitting = true
	sprite.rotation_degrees = 90
	
	death_snd.play()
	
	# Show the game over screen
	_show_game_over("You Died!")
	

func _show_game_over(reason):
	PlayerStats.health = 6
	
	game_over_text.text = reason
	
	retry_btn.mouse_filter = Control.MOUSE_FILTER_STOP
	quit_btn.mouse_filter = Control.MOUSE_FILTER_STOP
	
	game_over.visible = true

# Lets the animation player toggle which step sound to play
func _toggle_step():
	step = !step
	
	if step:
		step_snd.pitch_scale = 1.1
	else:
		step_snd.pitch_scale = 0.6
