class_name PropProgress
extends PropVar

@export_range(0.0, 1.0) var value: float:
	get: return super._ret() / _max
	set(new_val): super._put(lerp(0.0, _max, new_val))

var _max: float

func _init(obj: Object, path: NodePath, max: float = 1.0):
	super(obj, path)
	_max = max
