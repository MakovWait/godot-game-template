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


func _use_import_plugin(plugin: EditorImportPlugin):
	add_import_plugin(plugin)
	on_cleanup(func():
		remove_import_plugin(plugin)
	)


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


func _use_debugger_plugin(script: EditorDebuggerPlugin):
	add_debugger_plugin(script)
	on_cleanup(func():
		remove_debugger_plugin(script)
	)


func _use_tool_menu_item(name: String, callable: Callable) -> void:
	add_tool_menu_item(name, callable)
	on_cleanup(func():
		remove_tool_menu_item(name)
	)


func _use_tool_submenu_item(name: String, submenu: PopupMenu) -> void:
	add_tool_submenu_item(name, submenu)
	on_cleanup(func():
		remove_tool_menu_item(name)
	)


func _use_control_in_container(container: CustomControlContainer, control: Control) -> void:
	add_control_to_container(container, control)
	on_cleanup(func():
		remove_control_from_container(container, control)
	)


func bind_node(node: Node) -> Node:
	on_cleanup(func() -> void:
		node.queue_free()
	)
	return node
