@tool
extends EasyEditorPlugin


func _use() -> void:
	_use_tool_menu_item(
		"Import Palette", 
		_import_palette.bind("res://assets/palette.png")
	)

	var file_dialog := EditorFileDialog.new()
	file_dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	file_dialog.file_selected.connect(func(path: String):
		_import_palette(path)
	)
	get_editor_interface().get_base_control().add_child(file_dialog)
	on_cleanup(func():
		file_dialog.queue_free()
	)
	_use_tool_menu_item(
		"Import Palette From File", 
		func():
			file_dialog.popup_file_dialog()
	)

	var select_text_file := EditorFileDialog.new()
	select_text_file.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	select_text_file.file_selected.connect(func(path: String):
		_import_palette_from_text_file(path)
	)
	get_editor_interface().get_base_control().add_child(select_text_file)
	on_cleanup(func():
		select_text_file.queue_free()
	)
	_use_tool_menu_item(
		"Import Palette From Text File", 
		func():
			select_text_file.popup_file_dialog()
	)


func _import_palette_from_text_file(path: String) -> void:
	var arr: PackedColorArray = []
	var file_str := FileAccess.get_file_as_string(path)
	for line in file_str.split("\n"):
		arr.append(Color.from_string(line, Color.FUCHSIA))
	var settings = get_editor_interface().get_editor_settings()
	settings.set_project_metadata("color_picker", "presets", arr)


# https://github.com/firebelley/godot-addons/blob/6f83835a99d1c2e8c14f3dda3d2a8082a2a4a64a/palette_importer/plugin.gd#L34
func _import_palette(path: String) -> void:
	var image = Image.new()
	image.load(path)
	
	var color_dictionary = {}
	
	for x in image.get_width():
		for y in image.get_height():
			var color = image.get_pixelv(Vector2i(x, y))
			color_dictionary[color.to_html()] = color

	var settings = get_editor_interface().get_editor_settings()
	var arr: PackedColorArray = []
	for key in color_dictionary.keys():
		arr.append(color_dictionary[key])
	settings.set_project_metadata("color_picker", "presets", arr)
