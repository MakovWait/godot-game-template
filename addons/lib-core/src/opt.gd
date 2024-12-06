class_name Opt

var _data

func _init(data=null):
	_data = data

func is_null() -> bool:
	return _data == null

func is_not_null() -> bool:
	return _data != null

func unwrap() -> Variant:
	assert(not is_null())
	return _data

func unwrap_or(default: Variant) -> Variant:
	if is_null():
		return default
	else:
		return _data

func unwrap_or_else(default: Callable) -> Variant:
	if is_null():
		return default.call()
	else:
		return _data

func map(f: Callable) -> Opt:
	if is_null():
		return Opt.new()
	return Opt.new(f.call(_data))

func instead_else(f: Callable) -> Opt:
	if is_null():
		return f.call()
	return self

func inspect(f: Callable) -> Opt:
	if not is_null():
		f.call(_data)
	return self

func _to_string():
	if is_null():
		return "Null[]"
	else:
		return "Opt[%s]" % _data

static func lazy(f: Callable) -> Callable:
	return func(): return Opt.new(f.call())
