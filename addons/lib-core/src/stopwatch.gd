class_name Stopwatch
extends Node


var _time_sec := 0.0


func secs() -> float:
	return _time_sec


func reset() -> void:
	_time_sec = 0.0


func pause() -> void:
	set_process(false)


func unpause() -> void:
	set_process(true)


func _process(delta: float) -> void:
	_time_sec += delta
