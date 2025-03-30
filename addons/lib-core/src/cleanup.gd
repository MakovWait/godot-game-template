class_name Cleanup


static var _empty := Cleanup._Empty.new()


func invoke() -> void:
	pass


static func empty() -> Cleanup:
	return _empty


class _Empty extends Cleanup:
	func invoke() -> void:
		pass


const Func = _Func
class _Func extends Cleanup:
	var _callable: Callable
	
	func _init(callable: Callable) -> void:
		_callable = callable
	
	func invoke() -> void:
		_callable.call()
