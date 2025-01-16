class_name GamePluginGroup
extends GamePluginSource


@export var _game_plugins: Array[GamePluginSource]
@export var _disabled := false


func add_to(plugins: InstalledGamePlugins) -> void:
	if _disabled:
		return
	for plugin in _game_plugins:
		await plugin.add_to(plugins)
