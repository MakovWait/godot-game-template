extends Node


var _dict: Dictionary = {}


func add_portal_target(name: String, node: Node) -> void:
	assert(name not in _dict)
	assert(node != null)
	_dict[name] = node


func remove_portal_target(name: String) -> void:
	_dict.erase(name)


func get_portal_target(name: String) -> Node:
	var result := _dict[name] as Node
	return result
