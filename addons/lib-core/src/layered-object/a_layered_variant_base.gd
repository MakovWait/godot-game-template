class_name ALayeredVariant
extends LayeredObject


func _init(value: Variant) -> void:
	var v := V.new(value)
	super._init(v)


## [codeblock]
## func(obj: ALayeredVariant.V) -> Callable:
##     var prev_value: Variant = obj.value
##     # impl
##     return func() -> void:
##         obj.value = prev_value
## [/codeblock]
func add_layer(mod: Callable) -> LayerHandle:
	return super.add_layer(mod)


## Simple Layer is a shortcut for [method ALayeredVariant.add_layer] with the following structure:
## [codeblock]
## func(obj: ALayeredVariant.V) -> void:
##     var prev_value: Variant = obj.value
##     mod.call(obj)
##     return func() -> void:
##         obj.value = prev_value
## [/codeblock]
##
## [code]mod[/code] is [Callable] of type:
## [codeblock]
## func(obj: ALayeredVariant.V) -> void:
##     # do something with obj
##     pass
## [/codeblock]
func add_simple_layer(mod: Callable) -> LayerHandle:
	return super.add_layer(func(obj: V) -> Callable:
		var prev_value: Variant = obj.value
		mod.call(obj)
		return func() -> void:
			obj.value = prev_value
	)


func _value() -> Variant:
	return _obj.value


func _override_with(new_value: Variant) -> LayeredObject.LayerHandle:
	return self.add_layer(
		func(v: V) -> Callable:
			return v.override(new_value)\
	)


class V:
	var value: Variant
	
	func _init(value: Variant) -> void:
		self.value = value
	
	func override(new_value: Variant) -> Callable:
		var prev := value
		value = new_value
		return func() -> void:
			value = prev
