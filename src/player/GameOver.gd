extends CanvasLayer



func _on_Retry_pressed():
	$Retry.disabled = true
	EventBus.emit_signal("reload_scene")


func _on_Quit_pressed():
	$Retry.disabled = true
	get_tree().reload_current_scene()
