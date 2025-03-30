@tool
class_name ScriptSource
extends Resource


@export var _script: Script:
	set(value):
		_script = value
		if Engine.is_editor_hint():
			notify_property_list_changed()
var _args: Dictionary = {}


func instantiate() -> Object:
	var instance := _script.call("new", _args)
	for key: String in _args.keys():
		instance.set(key, _args[key])
	return instance


func _get(property: StringName) -> Variant:
	if _script_has_property(_script, property):
		return _args.get(property)
	return null


func _set(property: StringName, value: Variant) -> bool:
	if _script_has_property(_script, property):
		_args[property] = value
		return true
	return false


func _property_can_revert(property: StringName) -> bool:
	return _script_has_property(_script, property)


func _property_get_revert(property: StringName) -> Variant:
	return _script.get_property_default_value(property)


func _get_property_list() -> Array[Dictionary]:
	if _script == null:
		return []
	return _script.get_script_property_list()


func _script_has_property(script: Script, property: StringName) -> bool:
	if _script == null:
		return false
	for prop in _script.get_script_property_list():
		if prop["name"] == property:
			return true
	return false
