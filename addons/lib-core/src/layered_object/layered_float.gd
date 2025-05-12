class_name LayeredFloat
extends ALayeredVariant


func _init(value: float) -> void:
	super._init(value)


func value() -> float:
	return self._value()


func override_with(new_value: float) -> LayeredObject.LayerHandle:
	return self._override_with(new_value)


func add_value(value_to_add: float) -> LayeredObject.LayerHandle:
	return self.add_simple_layer(
		func(obj: ALayeredVariant.V) -> void:
			obj.value += value_to_add
	)
