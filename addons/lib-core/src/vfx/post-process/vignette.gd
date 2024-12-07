@tool
class_name Vignette
extends CanvasLayer

@onready var _color_rect: ColorRect = $ColorRect

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_EDITOR) 
@onready var intensity := PropFloat.new(_color_rect.material, "shader_parameter/vignette_intensity")

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_EDITOR) 
@onready var opacity := PropProgress.new(_color_rect.material, "shader_parameter/vignette_opacity", 1.0)

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_EDITOR) 
@onready var rgb := PropColor.new(_color_rect.material, "shader_parameter/vignette_rgb")
