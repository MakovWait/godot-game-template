class_name PropertySetter
extends Node


@export var _target: NodePath = ".."
@export var _property_path: String
@export var _source: VariantSource


func _ready() -> void:
	get_node(_target).set_indexed(_property_path, _source.value())
