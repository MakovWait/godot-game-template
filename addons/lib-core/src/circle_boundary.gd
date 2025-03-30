class_name CircleBoundary
extends Node2D


@export_flags_2d_physics var collision_layer: int
@export_flags_2d_physics var collision_mask: int
@export var radius: float = 100.0
@export var segment_count: int = 32
@export var wall_thickness: float = 10.0
@export var one_way_margin: float = 2.0


func _ready():
	for i in range(segment_count):
		var angle = (i / float(segment_count)) * TAU
		var next_angle = ((i + 1) / float(segment_count)) * TAU

		var point1 = Vector2(cos(angle), sin(angle)) * radius
		var point2 = Vector2(cos(next_angle), sin(next_angle)) * radius

		var mid_point = (point1 + point2) / 2.0
		var direction = point2 - point1
		var segment_length = direction.length()
		var tangent_angle = direction.angle()

		var body := StaticBody2D.new()
		body.collision_layer = collision_layer
		body.collision_mask = collision_mask

		var shape := RectangleShape2D.new()
		shape.size = Vector2(segment_length, wall_thickness)

		var collision := CollisionShape2D.new()
		collision.shape = shape
		collision.one_way_collision = true
		collision.one_way_collision_margin = one_way_margin

		collision.position = mid_point
		# ВНИМАНИЕ: добавляем поворот на 180 градусов, чтобы -Y смотрел НАРУЖУ круга
		collision.rotation = tangent_angle + PI

		body.add_child(collision)
		add_child(body)
