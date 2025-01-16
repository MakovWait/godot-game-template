class_name PortalTargetAdd
extends Node


@export var _name: String
@export var _target: NodePath = ".."


func _enter_tree() -> void:
	PortalHub.add_portal_target(_name, get_node(_target))


func _exit_tree() -> void:
	PortalHub.remove_portal_target(_name)
