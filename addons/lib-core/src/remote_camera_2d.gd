class_name RemoteCamera2D
extends Node2D


@export var _origin_path: NodePath = ".."
@export var _target: Camera2D

@onready var _origin := get_node(_origin_path) as Camera2D


func setup(origin_path: NodePath, target: Camera2D) -> void:
	_origin_path = origin_path
	_target = target


func enable(enabled: bool) -> void:
	set_process(enabled)


func force_update() -> void:
	_target.global_transform = _origin.global_transform
	_target.offset = _origin.offset
	_target.zoom = _origin.zoom
	
	_target.ignore_rotation = _origin.ignore_rotation
	_target.rotation = _origin.rotation


func _process(delta: float) -> void:
	force_update()
