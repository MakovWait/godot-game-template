class_name ViewportLayerTextureSetter
extends Node


@export var _target: NodePath = ".."
@export var _property: String = "texture"
@export var _layer: ViewportLayer


func _ready() -> void:
	get_node(_target).set_indexed(
		_property,
		_layer.viewport_texture()
	)
