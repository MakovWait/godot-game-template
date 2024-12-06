extends "res://addons/gd-plug/plug.gd"


func _plugging() -> void:
	plug("MakovWait/godot-expand-region", {"exclude": ["addons/gdUnit4"]})
	plug("MakovWait/godot-find-everywhere")
	plug("MakovWait/godot-previous-tab")
	plug("MakovWait/godot-script-tabs")
	plug("MakovWait/improved_resource_picker")
	#plug("MakovWait/godot-devconsole")
	plug("MakovWait/godot-resource-viewer")
	plug("MakovWait/godot-use-context")
