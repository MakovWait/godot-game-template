@tool
extends EasyEditorPlugin


var _file_dialog: EditorFileDialog


func _use() -> void:
	_use_tool_menu_item(
		"Import Palette", 
		_import_palette.bind("res://assets/palette.png")
	)

	_file_dialog = EditorFileDialog.new()
	_file_dialog.file_mode = EditorFileDialog.FILE_MODE_OPEN_FILE
	_file_dialog.file_selected.connect(func(path: String):
		_import_palette(path)
	)
	get_editor_interface().get_base_control().add_child(_file_dialog)
	on_cleanup(func():
		_file_dialog.queue_free()
		_file_dialog = null
	)
	_use_tool_menu_item(
		"Import Palette From File", 
		func():
			_file_dialog.popup_file_dialog()
	)


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
