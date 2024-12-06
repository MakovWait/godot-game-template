class_name LayeredObject

var _obj: Object
var _mods: Array[AppliedModifier] = []


func _init(obj: Object) -> void:
	_obj = obj


func add(mod: Callable) -> LayerHandle:
	var is_added = _find_index(mod) != -1
	assert(not is_added)
	
	var applied_mod = AppliedModifier.new(_obj, mod)
	_mods.append(applied_mod)
	applied_mod.do()
	
	return LayerHandle.new(applied_mod, self)


func remove(mod_to_remove: Callable):
	var idx_to_remove = self._find_index(mod_to_remove)
	var was_added = idx_to_remove > -1
	assert(was_added)
	
	for i in range(len(_mods) - 1, idx_to_remove, -1):
		var mod = _mods[i]
		mod.undo()
	
	if idx_to_remove > -1:
		_mods[idx_to_remove].undo()
		_mods.remove_at(idx_to_remove)
	
	for i in range(idx_to_remove, len(_mods)):
		_mods[i].do()


func replace(mod_to_replace: Callable):
	var idx_to_replace = self._find_index(mod_to_replace)
	var was_added = idx_to_replace > -1
	assert(was_added)
	
	for i in range(len(_mods) - 1, idx_to_replace - 1, -1):
		var mod = _mods[i]
		mod.undo()
	
	for i in range(idx_to_replace, len(_mods)):
		_mods[i].do()


func clear() -> void:
	for i in range(len(_mods) - 1, -1, -1):
		var mod = _mods[i]
		mod.undo()
	_mods.clear()


func _find_last_index(mod: Callable):
	for i in range(len(_mods) - 1, -1, -1):
		if _mods[i].mod_is(mod):
			return i
	return -1


func _find_index(mod: Callable) -> int:
	for i in range(len(_mods)):
		if _mods[i].mod_is(mod):
			return i
	return -1


class LayerHandle:
	var _layer: AppliedModifier
	var _layers: LayeredObject
	
	func _init(layer: AppliedModifier, layers: LayeredObject) -> void:
		_layer = layer
		_layers = layers
	
	func remove():
		_layers.remove(_layer._mod)
	
	func replace():
		_layers.replace(_layer._mod)


class AppliedModifier:
	var _mod: Callable
	var _obj: Object
	var _undo: Callable
	
	func _init(obj: Object, mod: Callable) -> void:
		self._obj = obj
		self._mod = mod
	
	func do():
		_undo = _mod.call(_obj)
	
	func undo():
		_undo.call()
		_undo = func(): pass
	
	func mod_is(mod: Callable) -> bool:
		return _mod == mod
