class_name RemoteOwner
extends Node


@export var _nodes: Array[Node]


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		for node in _nodes:
			node.queue_free()
