class_name TickTimer
extends Timer

signal tick
signal depleted


var _ticks_max := 0
var _ticks_current := 0


func _ready() -> void:
	one_shot = false
	timeout.connect(func() -> void:
		_ticks_current += 1
		tick.emit()
		if _ticks_current >= _ticks_max:
			stop()
			depleted.emit()
	)


func set_max_ticks(ticks: int) -> void:
	_ticks_max = ticks


func reset_ticks() -> void:
	_ticks_current = 0
