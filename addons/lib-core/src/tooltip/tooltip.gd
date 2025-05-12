class_name Tooltip
extends MarginContainer


func _ready() -> void:
	utils.set_mouse_filter_recursive(self, Control.MOUSE_FILTER_IGNORE)


func _process(delta: float) -> void:
	_update_tooltip_position(get_global_mouse_position(), Vector2(20, 20))


func _update_tooltip_position(tooltip_pos: Vector2, tooltip_offset: Vector2):
	var tooltip_popup: Control = self
	var r := Rect2(tooltip_pos + tooltip_offset, tooltip_popup.get_combined_minimum_size())
	var vr := tooltip_popup.get_viewport().get_visible_rect().grow_individual(
		-100, -32, -100, -32
	)
	r.size = r.size.ceil()
	r.size = r.size.min(vr.size)
	
	if r.position.x + r.size.x > vr.position.x + vr.size.x:
		r.position.x = tooltip_pos.x - r.size.x - tooltip_offset.x
		if r.position.x < vr.position.x:
			r.position.x = vr.position.x + vr.size.x - r.size.x
	elif r.position.x < vr.position.x:
		r.position.x = vr.position.x

	if r.position.y + r.size.y > vr.position.y + vr.size.y:
		r.position.y = tooltip_pos.y - r.size.y - tooltip_offset.y
		if r.position.y < vr.position.y:
			r.position.y = vr.position.y + vr.size.y - r.size.y
	elif r.position.y < vr.position.y:
		r.position.y = vr.position.y

	tooltip_popup.global_position = utils.lerp_smoothing(
		tooltip_popup.global_position,
		r.position,
		get_process_delta_time(),
		0.1
	)
	tooltip_popup.size = r.size


func set_default_position(pos: Vector2) -> void:
	global_position = pos


static func of(content: Control) -> Tooltip:
	var tooltip := Tooltip.new()
	tooltip.top_level = true
	tooltip.add_child(content)
	return tooltip
