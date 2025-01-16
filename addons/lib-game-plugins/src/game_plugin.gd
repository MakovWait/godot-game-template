class_name GamePlugin
extends GamePluginSource


@export var _disabled: bool


func add_to(plugins: InstalledGamePlugins) -> void:
	if _is_disabled():
		return
	await plugins._add(self)


func build(plugin: BuiltGamePlugin) -> Callable:
	return await _build(plugin)


func name() -> String:
	return resource_path


func _build(plugin: BuiltGamePlugin) -> Callable:
	return _no_cleanup


func _is_disabled() -> bool:
	return false


func _no_cleanup() -> void:
	pass
