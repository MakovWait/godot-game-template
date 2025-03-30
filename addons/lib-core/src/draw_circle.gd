@tool
class_name DrawCircle
extends Node2D


@export var _color: ColorSource:
	set(value):
		_color = value
		queue_redraw()


@export var _radius: float = 64:
	set(value):
		_radius = value
		queue_redraw()


@export var _filled := true:
	set(value):
		_filled = value
		queue_redraw()


@export var _width := -1.0:
	set(value):
		_width = value
		queue_redraw()


@export var _antialiased := false:
	set(value):
		_antialiased = value
		queue_redraw()


func _draw() -> void:
	var color := Color.WHITE
	if _color != null:
		color = _color.value()
	draw_circle(Vector2.ZERO, _radius, color, _filled, _width, _antialiased)
