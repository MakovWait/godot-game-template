class_name Counter


var _value: int
var _max_value: int

var _default_value: int
var _default_max_value: int


func _init(value: int, max_value: int) -> void:
	_value = value
	_default_value = value
	
	_max_value = max_value
	_default_max_value = max_value


func reset_to_default() -> void:
	_value = _default_value
	_max_value = _default_max_value


func reload() -> void:
	_value = 0


func inc() -> void:
	_value += 1


func value() -> int:
	return _value


func is_zero() -> bool:
	return _value == 0


func remaining() -> int:
	return max(_max_value - _value, 0)


func set_value(new_value: int) -> void:
	_value = new_value


func copy_value(counter: Counter) -> void:
	_value = counter.value()


func set_as_maxed() -> void:
	_value = _max_value


func set_max(new_max: int) -> void:
	_max_value = new_max


func max() -> int:
	return _max_value


func is_maxed() -> bool:
	return _value >= _max_value
