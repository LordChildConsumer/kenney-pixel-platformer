extends Node2D

func _ready():
	EventBus.connect("level_complete", self, "_on_Level_Complete")

func _on_Level_Complete():
	pass
