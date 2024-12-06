class_name Boot
extends Node2D

@export var constants: Constants

func _ready() -> void:
	assert(G.Constants == null)
	G.Constants = constants

	if not OS.is_debug_build():
		get_window().mode = Window.MODE_FULLSCREEN
		get_window().always_on_top = false
