class_name TooltipSpawnRoot
extends Control


var _current_tooltip: Tooltip
## Opt[Vector2]
var _last_pos := Opt.new()


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE


## [codeblock]
## func() -> Tooltip:
##    pass
## [/codeblock]
func connect_tooltip_source(
	tooltip_source: Control,
	tooltip_factory: Callable
) -> void:
	tooltip_source.mouse_entered.connect(func() -> void:
		var tooltip: Tooltip = tooltip_factory.call()
		if tooltip != null:
			_spawn_tooltip(tooltip_source, tooltip)
	)
	tooltip_source.mouse_exited.connect(func() -> void:
		if _current_tooltip:
			_current_tooltip.queue_free()
			_last_pos = Opt.of(_current_tooltip.global_position)
			_current_tooltip = null
	)


func _spawn_tooltip(source: Control, tooltip: Tooltip) -> void:
	assert(_current_tooltip == null)
	add_child(tooltip)
	_current_tooltip = tooltip
	_current_tooltip.set_default_position(_last_pos.unwrap_or(get_global_mouse_position()))
