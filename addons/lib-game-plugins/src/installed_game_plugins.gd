class_name InstalledGamePlugins
extends Node


var _built_plugins: Array[BuiltGamePlugin]


func _add(plugin: GamePlugin) -> void:
	var built_plugin := BuiltGamePlugin.new()
	var cleanup := await plugin.build(built_plugin)
	built_plugin.on_cleanup(cleanup)
	_built_plugins.append(built_plugin)


func finish() -> void:
	for plugin in _built_plugins:
		await plugin.finish()


func validate() -> void:
	for plugin in _built_plugins:
		await plugin.validate()


func cleanup() -> void:
	for plugin in _built_plugins:
		await plugin.cleanup()
	_built_plugins.clear()
