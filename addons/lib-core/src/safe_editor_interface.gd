static var I: Variant:
#static var I: EditorInterface:
	get: return Engine.get_singleton("EditorInterface")


static func resource_filesystem_update_file(path: String) -> void:
	I.get_resource_filesystem().update_file(path)


static func edit_script(script: Script, line: int = -1, column: int = 0, grab_focus: bool = true) -> void:
	I.edit_script(script, line, column, grab_focus)
