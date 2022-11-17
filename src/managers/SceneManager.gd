extends Node

# Node References
onready var anim = $Transition/AnimationPlayer
onready var current_scene = $CurrentScene

# Constants


# Variables
var loaded_scene

# -----------------------
# --- Godot Functions ---
# -----------------------

func _ready():
	EventBus.connect("quit_game", self, "_quit_game")
	EventBus.connect("switch_scene", self, "_switch_scene")
	EventBus.connect("reload_scene", self, "_reload_scene")

func _process(delta):
	pass

func _physics_process(delta):
	pass


# ------------------------
# --- Custom Functions ---
# ------------------------

# Switch scenes
func _switch_scene(new_scene):
	anim.play("fade_to_black")
	yield(anim, "animation_finished")
	current_scene.get_child(0).queue_free()
	
	loaded_scene = new_scene
	
	current_scene.add_child(new_scene.instance())
	anim.play("fade_to_game")

func _reload_scene():
	anim.play("fade_to_black")
	yield(anim, "animation_finished")
	current_scene.get_child(0).queue_free()
	
	current_scene.add_child(loaded_scene.instance())
	anim.play("fade_to_game")

func _quit_game():
	anim.play("fade_to_black")
	yield(anim, "animation_finished")
	get_tree().quit()
