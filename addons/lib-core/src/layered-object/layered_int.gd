class_name LayeredInt
extends ALayeredVariant


func _init(value: int) -> void:
	super._init(value)


func value() -> int:
	return self._value()


func override_with(new_value: int) -> LayeredObject.LayerHandle:
	return self._override_with(new_value)
