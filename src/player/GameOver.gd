extends CanvasLayer



func _on_Retry_pressed():
	$Retry.mouse_filter = Control.MOUSE_FILTER_IGNORE
	SceneManager.reload_current_scene()


func _on_Quit_pressed():
	$Retry.mouse_filter = Control.MOUSE_FILTER_IGNORE
	SceneManager.load_new_scene("res://src/menus/MainMenu.tscn")
