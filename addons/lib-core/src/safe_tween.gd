class_name SafeTween

var _tween: Tween
var _on_kill


func kill():
	if is_running():
		_tween.stop()
		_tween.kill()
		if _on_kill:
			_on_kill.call()
	_on_kill = null


func is_running():
	return _tween != null and _tween.is_running()


func get_from(node: Node, on_kill=null) -> Tween:
	kill()
	_tween = node.create_tween()
	_on_kill = on_kill
	return _tween
