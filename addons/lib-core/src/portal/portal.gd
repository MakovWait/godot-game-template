class_name Portal
extends Node


@export var _portal_target_name: String

var _target: Node


func _ready() -> void:
	_late_init.call_deferred()


func _late_init() -> void:
	_target = PortalHub.get_portal_target(_portal_target_name)
	child_entered_tree.connect(func(child: Node) -> void:
		_teleport.call_deferred(child)
	)
	_teleport_all_children()


func _teleport_all_children() -> void:
	for child in get_children():
		self._teleport(child)


func _teleport(node: Node) -> void:
	assert(node.get_parent() == self)
	node.reparent(_target)
