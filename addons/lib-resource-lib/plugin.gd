@tool
extends EasyEditorPlugin


func _use() -> void:
	var reload_btn := Button.new()
	reload_btn.theme_type_variation = "ToolButton"
	reload_btn.tooltip_text = "Reload Plugins"
	reload_btn.pressed.connect(_reload)
	reload_btn.icon = EditorInterface.get_base_control().get_theme_icon("Reload", "EditorIcons")
	_use_control_in_container(CONTAINER_TOOLBAR, reload_btn)


func _build() -> bool:
	_reload()
	return true


func _reload() -> void:
	var start = Time.get_unix_time_from_system()
	var lib := ResourceLib._load_for_reload()
	var fs := EditorInterface.get_resource_filesystem().get_filesystem_path("res://")
	_scan_resources(fs, func(dir: EditorFileSystemDirectory, idx: int):
		var path := dir.get_file_path(idx)
		lib._add_resource_path(path)
	)
	var err := lib._save()
	var end = Time.get_unix_time_from_system()
	print("Rebuilt ResourceLib in %.2f seconds with exit code %s(%s)." % [
		end-start, error_string(err), err
	])


func _scan_resources(dir: EditorFileSystemDirectory, visit: Callable):
	for i in range(dir.get_subdir_count()):
		_scan_resources(dir.get_subdir(i), visit)
	
	for i in range(dir.get_file_count()):
		if dir.get_file_type(i) == "Resource" && dir.get_file_import_is_valid(i):
			visit.call(dir, i)
