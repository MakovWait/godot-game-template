@tool
extends EasyEditorPlugin


func _use():
	_use_inspector_plugin(SceneSourceInspector.new())


class SceneSourceInspector extends EditorInspectorPlugin:
	func _can_handle(object):
		return object is SceneSource

	func _parse_begin(object):
		var refresh_btn = Button.new()
		refresh_btn.text = "Reload Properties"
		refresh_btn.pressed.connect(func():
			object._reload_properties()
		)
		add_custom_control(refresh_btn)
