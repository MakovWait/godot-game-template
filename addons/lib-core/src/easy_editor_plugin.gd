@tool
class_name EasyEditorPlugin
extends EditorPlugin

var cleanups: Array[Callable] = []


func _enter_tree() -> void:
	_use()


func _exit_tree() -> void:
	for cleanup in cleanups:
		cleanup.call()


func on_cleanup(cleanup: Callable):
	cleanups.append(cleanup)


func _use():
	pass


func _use_inspector_plugin(inspector: EditorInspectorPlugin):
	add_inspector_plugin(inspector)
	on_cleanup(func():
		remove_inspector_plugin(inspector)
	)


func _use_autoload_singleton(name: String, path: String):
	add_autoload_singleton(name, path)
	on_cleanup(func():
		remove_autoload_singleton(name)
	)
