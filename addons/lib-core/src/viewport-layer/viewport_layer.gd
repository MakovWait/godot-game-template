class_name ViewportLayer
extends CanvasLayer


@export var _camera_to_follow: Camera2D
@export var _camera_pos_smoothing_enabled := true


@export_group("Internal")
@export var _viewport: SubViewport
@export var _root: Node2D
@export var _camera: Camera2D

var _default_viewport: Viewport
var _remote_camera: RemoteCamera2D


func root() -> Node2D:
	return _root

## may be null
func remote_camera() -> RemoteCamera2D:
	return _remote_camera


func _ready() -> void:
	_default_viewport = get_viewport()
	
	_viewport.size = Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height"),
	)
	_viewport.transparent_bg = true
	_viewport.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST
	
	custom_viewport = _viewport
	offset = Vector2.ZERO
	#offset = custom_viewport_override.size / 2
	_camera.custom_viewport = _viewport
	_camera.position_smoothing_enabled = _camera_pos_smoothing_enabled
	follow_viewport_enabled = false
	follow_viewport_enabled = true
	
	if _camera_to_follow != null:
		_remote_camera = RemoteCamera2D.new()
		_remote_camera.setup("..", _camera)
		_camera_to_follow.add_child(_remote_camera)


func _enter_tree() -> void:
	request_ready()


func _exit_tree() -> void:
	custom_viewport = _default_viewport


func viewport_texture() -> Texture2D:
	return _viewport.get_texture()
