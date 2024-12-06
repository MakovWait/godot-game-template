class_name SceneTransition

func add_to(node: Node):
	pass

func fade_in(callback: Callable):
	pass

func fade_out(callback: Callable):
	pass


class Derived extends SceneTransition:
	var _delegate
	
	func _init(delegate):
		_delegate = delegate
	
	func add_to(node: Node):
		_delegate.add_to(node)
	
	func fade_in(callback: Callable):
		_delegate.fade_in(callback)

	func fade_out(callback: Callable):
		_delegate.fade_out(callback)


class Instant extends SceneTransition:
	func add_to(node):
		pass
	
	func fade_in(callback):
		callback.call()

	func fade_out(callback):
		callback.call()
