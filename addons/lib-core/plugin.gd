@tool
extends EasyEditorPlugin


func _use():
	_use_debugger_plugin(preload("./src/debug/plugin.gd").new())
	_use_autoload_singleton("Debug", "./src/debug/debug.tscn")
	_use_autoload_singleton("PauseTree", "./src/pause_tree.gd")
	_use_autoload_singleton("PortalHub", "./src/portal/portal_hub.gd")
	_use_autoload_singleton("CurrentScene", "./src/current-scene/current_scene.tscn")
