class_name ViewportLayerTextureRect
extends TextureRect


@export var _layer: ViewportLayer


func _ready() -> void:
	_setup.call_deferred()


func _setup() -> void:
	texture = _layer.viewport_texture()
