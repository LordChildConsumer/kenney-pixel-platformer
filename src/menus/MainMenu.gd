extends Control

# Node/Scene References
onready var StartWorld = preload("res://src/worlds/DevWorld.tscn")

# Constants


# Variables


# -----------------------
# --- Godot Functions ---
# -----------------------

func _ready():
	pass

func _process(delta):
	pass

func _physics_process(delta):
	pass


# ------------------------
# --- Custom Functions ---
# ------------------------

# Put functions here

func _on_Start_pressed():
	disable_buttons()
	EventBus.emit_signal("switch_scene", StartWorld)


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	EventBus.emit_signal("quit_game")

func disable_buttons():
	$Start.disabled = true
	$Settings.disabled = true
