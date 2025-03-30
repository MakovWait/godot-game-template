@tool
class_name ResourceLib
extends Resource


const _path: StringName = "res://resource_lib.tres"


@export var _resource_paths: Array[String]


static func load_all() -> Array[Resource]:
	var result: Array[Resource]
	var instance := _load_self()
	for path in instance._resource_paths:
		result.append(ResourceLoader.load(path))
	return result


static func _load_self() -> ResourceLib:
	return ResourceLoader.load(_path)


func _add_resource_path(resource_path_to_add: String) -> void:
	if _path == resource_path_to_add:
		return
	_resource_paths.append(resource_path_to_add)


static func _load_for_reload() -> ResourceLib:
	assert(Engine.is_editor_hint())
	var lib: ResourceLib
	if FileAccess.file_exists(_path):
		lib = ResourceLoader.load(_path)
	else:
		lib = ResourceLib.new()
		lib.resource_path = _path
	lib._resource_paths.clear()
	return lib


func _save() -> Error:
	assert(Engine.is_editor_hint())
	var err := ResourceSaver.save(self, _path)
	SafeEditorInterface.resource_filesystem_update_file(_path)
	return err
