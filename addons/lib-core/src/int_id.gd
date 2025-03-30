class_name IntId


var _last_id: int


func last() -> int:
	return _last_id


func next() -> int:
	_last_id += 1
	return _last_id
