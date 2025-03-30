class_name EditorPropertySchema


var name: StringName
var type: Variant.Type
var hint: PropertyHint = PROPERTY_HINT_NONE
var hint_string: String  = ""
var usage: PropertyUsageFlags = PROPERTY_USAGE_DEFAULT
var _class_name: StringName
var clazz_name: StringName:
	get: return _class_name


func _init(name: StringName, type: Variant.Type) -> void:
	self.name = name
	self.type = type


func with_class_name(name: StringName) -> EditorPropertySchema:
	self._class_name = name
	return self


func with_hint(hint: PropertyHint) -> EditorPropertySchema:
	self.hint = hint
	return self


func with_hint_string(hint_string: String) -> EditorPropertySchema:
	self.hint_string = hint_string
	return self


func with_hint_and_string(hint: PropertyHint, hint_string: String) -> EditorPropertySchema:
	self.hint = hint
	self.hint_string = hint_string
	return self


func with_usage(usage: PropertyUsageFlags) -> EditorPropertySchema:
	self.usage = usage
	return self


func _get(property: StringName) -> Variant:
	if property == "class_name":
		return _class_name
	return null


func _set(property: StringName, value: Variant) -> bool:
	if property == "class_name":
		_class_name = value
		return true
	return false


func to_dict() -> Dictionary:
	return  {
		"name": self.name,
		"class_name": self.clazz_name,
		"type": self.type,
		"hint": self.hint,
		"hint_string": self.hint_string,
		"usage": self.usage,
	}


static func from_dict(dict: Dictionary) -> EditorPropertySchema:
	var schema := EditorPropertySchema.new(dict.name, dict.type)
	for key in dict.keys():
		schema.set(key, dict[key])
	return schema
