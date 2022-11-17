class_name Actor
extends KinematicBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

export var _move_speed := 600.0
export var _max_jumps := 2
export var _jump_force := 1200.0
export var _jumps_made := 0
