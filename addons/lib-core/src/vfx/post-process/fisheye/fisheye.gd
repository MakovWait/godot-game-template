@tool
class_name Fisheye
extends CanvasLayer

@onready var _color_rect: ColorRect = $ColorRect

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_EDITOR) 
@onready var effect_amount := PropFloat.new(_color_rect.material, "shader_parameter/effect_amount")
