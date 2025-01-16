class_name BuiltGamePlugin
extends RefCounted

static var _empty := func() -> void: pass

var _on_finish: Callable = _empty
var _on_validate: Callable = _empty
var _on_cleanup: Callable = _empty


func finish() -> void:
	await _on_finish.call()


func validate() -> void:
	await _on_validate.call()


func cleanup() -> void:
	await _on_cleanup.call()


func on_finish(callable: Callable) -> BuiltGamePlugin:
	_on_finish = callable
	return self


func on_validate(callable: Callable) -> BuiltGamePlugin:
	_on_validate = callable
	return self


func on_cleanup(callable: Callable) -> BuiltGamePlugin:
	_on_cleanup = callable
	return self
