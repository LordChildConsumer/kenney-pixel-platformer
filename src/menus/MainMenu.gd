extends Control

# Node/Scene References
const STARTWORLD = "res://src/worlds/DevWorld.tscn"

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
	SceneManager.call_deferred("load_new_scene", STARTWORLD)


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()

func disable_buttons():
	$Start.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Settings.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Exit.mouse_filter = Control.MOUSE_FILTER_IGNORE
