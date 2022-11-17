extends Area2D

export var is_picked_up = false

onready var pickup_fx = $PickupFX
onready var pickup_snd = $PickupSND
onready var sprite = $Sprite

# When the player is within range
func _on_Coin_body_entered(body):
	if is_picked_up:
		return
	else:
		is_picked_up = true
		
		EventBus.emit_signal("coin_collected")
		
		pickup_fx.emitting = true
		pickup_snd.play()
		sprite.visible = false
		
		yield(get_tree().create_timer(pickup_fx.lifetime + 1), "timeout")
		self.queue_free()
