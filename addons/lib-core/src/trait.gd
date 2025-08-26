## [codeblock]
## func __trait_table__() -> Dictionary[Script, Object]:
##     pass
## [/codeblock]
class_name Trait


static func trait_obj_as(obj: Object, script: Script) -> Object:
	var result := trait_obj_as_strict(obj, script)
	if result == null:
		result = trait_obj_as_subtype(obj, script)
	return result


static func trait_obj_as_strict(obj: Object, script: Script) -> Object:
	var trait_table := _load_traits(obj)
	return trait_table.get(script, null)


static func trait_obj_as_subtype(obj: Object, script: Script) -> Object:
	var trait_table := _load_traits(obj)
	for value in trait_table.values():
		if is_instance_of(value, script):
			return value
	return null


static func preload_traits(obj: Object) -> void:
	assert(obj.has_method("__trait_table__"))
	var trait_table := obj.call("__trait_table__")
	obj.set_meta("__trait_table_cache__", trait_table)


static func _load_traits(obj: Object) -> Dictionary[Script, Object]:
	if not obj.has_meta("__trait_table_cache__"):
		preload_traits(obj)
	return obj.get_meta("__trait_table_cache__")
