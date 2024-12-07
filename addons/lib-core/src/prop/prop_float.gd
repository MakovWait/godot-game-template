class_name PropFloat
extends PropVar

@export var value: float:
	get: return super._ret()
	set(value): super._put(value)
