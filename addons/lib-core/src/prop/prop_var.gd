class_name PropVar
extends Resource

var _obj: Object
var _path: NodePath

func _init(obj: Object, path: NodePath):
	_obj = obj
	_path = path

func _ret():
	return _obj.get_indexed(_path)

func _put(new_val):
	_obj.set_indexed(_path, new_val)

func _property_can_revert(property: StringName) -> bool:
	return property == "value" and _obj.property_can_revert(String(_path))

func _property_get_revert(property: StringName) -> Variant:
	if property != "value":
		return null
	return _obj.property_get_revert(String(_path))
