@tool
extends EasyEditorPlugin


func _use():
	_use_autoload_singleton("PauseTree", "./src/pause_tree.gd")
	_use_autoload_singleton("CurrentScene", "./src/current-scene/current_scene.tscn")
