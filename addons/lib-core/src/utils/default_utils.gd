static func pop_random_from(arr: Array) -> Variant:
	var idx := randi_range(0, len(arr) - 1)
	var element = arr[idx]
	arr.remove_at(idx)
	return element


static func reparent_safe(
	node: Node, new_parent: Node, keep_global_transform: bool = true
) -> void:
	if node.get_parent() == null:
		new_parent.add_child(node)
	else:
		node.reparent(new_parent, keep_global_transform)


static func unparent(node: Node) -> void:
	var parent := node.get_parent()
	if parent != null:
		parent.remove_child(node)


## a - current_value
## b - target_value
## dt - just regular process delta
## t nominal duration until remaining distance is target precision p
## p target precision (1/100 - 1% of distance remaining)
static func lerp_smoothing(
	from: Variant, to: Variant, dt: float, t: float, p: float = 0.01
) -> Variant:
	return lerp(from, to, 1 - pow(p, dt / t))


## a - current_value
## b - target_value
## dt - just regular process delta
## t nominal duration until remaining distance is target precision p
## p target precision (1/100 - 1% of distance remaining)
static func lerpf_smoothing(
	from: float, to: float, dt: float, t: float, p: float = 0.01
) -> float:
	return lerp_smoothing(from, to, dt, t, p)


static func connect_with_token(s: Signal, callable: Callable, flags: int = 0) -> Callable:
	s.connect(callable, flags)
	return func() -> void:
		s.disconnect(callable)


static func random_dir(from := 0.0, to := 2 * PI) -> Vector2:
	var random_angle := randf_range(from, to)
	var direction := Vector2(1, 0).rotated(random_angle)
	return direction


static func not_implemented() -> Variant:
	assert(false, "Not Implemented!!")
	return null


static func readonly(value: Variant = null) -> void:
	assert(false, "Setter is readonly")
