class_name LayeredVariant
extends ALayeredVariant


func value() -> Variant:
	return self._value()


func override_with(new_value: Variant) -> LayeredObject.LayerHandle:
	return self._override_with(new_value)


func as_bool() -> bool:
	return self._value()


func as_int() -> int:
	return self._value()


func as_float() -> float:
	return self._value()
