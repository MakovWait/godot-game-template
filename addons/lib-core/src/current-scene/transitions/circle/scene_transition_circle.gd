extends CanvasLayer


@export var _min_idle_time = 0.0
@export var _fade_in_time = 0.3
@export var _fade_out_time = 0.3
@export_exp_easing var _ease_in = 3.45
@export_exp_easing var _ease_out = 0.449


@onready var _color_rect = $ColorRect
@onready var _label = $ColorRect/CenterContainer/RichTextLabel
@onready var _min_idle_timer = $MinIdleTimer

var _material: ShaderMaterial
var _text_to_set = "[center][tornado radius=1.0 freq=1.0]loading..."

func _ready():
	_material = _color_rect.material


func set_text(text):
	_text_to_set = text


func as_scene_transition() -> SceneTransition:
	return SceneTransition.Derived.new(self)


func add_to(node):
	node.add_child(self)


func fade_in(callback):
	#SoundManager.play_ui_sound(preload("res://lib/current-scene/transitions/circle/Whoosh 11_5.wav"))
	_label.hide()
	var tween = create_tween()
	tween.tween_method(_set_progress_with_curve(_ease_in), 0.0, 1.0, _fade_in_time);
	tween.tween_callback(func():
		if _min_idle_time > 0:
			_min_idle_timer.start(_min_idle_time)
	)
	tween.tween_callback(callback)


func fade_out(callback):
	if _min_idle_timer.is_stopped():
		_do_fade_out(callback)
	else:
		_min_idle_timer.timeout.connect(func():
			_do_fade_out(callback)
		)


func _do_fade_out(callback):
	var tween = create_tween()
	tween.tween_method(_set_progress_with_curve(_ease_out), 1.0, 0.0, _fade_out_time)
	tween.tween_callback(callback)
	tween.tween_callback(queue_free)


func _set_progress_with_curve(curve):
	return func(x): _set_progress(x, curve)


func _set_progress(x, curve):
	var progress = lerp(0.0, 1.05, ease(x, curve))
	if progress > 0.3 and not _label.is_visible_in_tree():
		_label.text = _text_to_set
		_label.show()
	_material.set_shader_parameter("progress", progress)
