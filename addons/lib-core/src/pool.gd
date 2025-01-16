class_name Pool


static func packed_scene_factory(scene: PackedScene) -> Callable:
	return func() -> Object: return scene.instantiate()


class Simple extends Node:
	var _factory: Callable
	var _ready_objects: Array[Object]

	func _init(lifetime_owner: Node, factory: Callable) -> void:
		_factory = factory
		lifetime_owner.add_child(self)
	
	func _notification(what: int) -> void:
		if what == NOTIFICATION_PREDELETE:
			dispose()
	
	func dispose() -> void:
		for obj in _ready_objects:
			_free_obj(obj)
		_ready_objects.clear()
	
	## virtual block
	func return_one(obj) -> void:
		_reset_obj(obj)
		_ready_objects.append(obj)

	func get_one() -> Object:
		if len(_ready_objects) > 0:
			return _ready_objects.pop_back()
		else:
			var obj := _factory.call() as Object
			_setup_obj(obj)
			return obj
	
	func _setup_obj(obj) -> void:
		pass
	
	func _reset_obj(obj) -> void:
		pass
	
	func _free_obj(obj):
		if obj.has_method("queue_free"):
			obj.call("queue_free")
		else:
			obj.free()
