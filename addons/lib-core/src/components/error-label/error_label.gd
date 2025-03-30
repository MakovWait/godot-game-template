class_name ErrorLabel
extends Label


var _appear_tween := SafeTween.new()


func _ready() -> void:
	visible = false
	await get_tree().process_frame
	scale = Vector2.ZERO


func force_hide() -> void:
	_appear_tween.kill()
	visible = false


func fade_in(visible_time: float = 0.3) -> void:
	await get_tree().process_frame
	pivot_offset = size / 2
	scale = Vector2.ZERO

	var tween = _appear_tween.get_from(self)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(Callable(self, "show"))
	tween.tween_property(self, "scale", Vector2.ONE, 0.5)
	tween.tween_interval(visible_time)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2.ZERO, 0.1)
	tween.tween_callback(Callable(self, "hide"))
