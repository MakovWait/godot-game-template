class_name LayeredBool
extends ALayeredVariant


func _init(value: bool) -> void:
	super._init(value)


func value() -> bool:
	return self._value()


func override_with(new_value: bool) -> LayeredObject.LayerHandle:
	return self._override_with(new_value)
