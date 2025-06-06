class_name TPauseTree
extends Node

@onready var _tree_paused = LayeredObject.new(get_tree())

func pause(debug_label: String = "") -> Lock:
	var handle = _tree_paused.add_layer(
		func(x: SceneTree):
			var prev = x.paused
			x.paused = true
			return func(): 
				x.paused = prev
	)
	handle.set_debug_name(debug_label)
	return Lock.new(handle)

func clear() -> void:
	_tree_paused.clear()

class Lock:
	var _handle: LayeredObject.LayerHandle
	
	func _init(handle: LayeredObject.LayerHandle) -> void:
		_handle = handle
	
	func release():
		_handle.remove()
	
	func release_safe():
		if _handle.exists():
			_handle.remove()
