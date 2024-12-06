class_name Prop


class Var:
	var _obj: Object
	var _path: NodePath

	func _init(obj: Object, path: NodePath):
		_obj = obj
		_path = path

	func ret():
		return _obj.get_indexed(_path)
	
	func put(new_val):
		_obj.set_indexed(_path, new_val)


class Float extends Var:
	func ret() -> float:
		return super.ret()

	func put(new_val: float):
		super.put(new_val)


class Vec2 extends Var:
	func ret() -> Vector2:
		return super.ret()

	func put(new_val: Vector2):
		super.put(new_val)


class Progress extends Var:
	var _max: float
	
	func _init(obj: Object, path: NodePath, max: float = 1.0):
		super(obj, path)
		_max = max
	
	func ret() -> float:
		return super.ret() / _max

	func put(new_val: float):
		super.put(lerp(0.0, _max, new_val))
