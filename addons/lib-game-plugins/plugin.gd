@tool
extends EasyEditorPlugin


func _use() -> void:
	_use_autoload_singleton("GamePlugins", "./src/game_plugins.gd")
