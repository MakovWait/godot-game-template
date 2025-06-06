extends Node


var _pause_lock: TPauseTree.Lock


func _ready() -> void:
	if not OS.is_debug_build():
		queue_free()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"pause_game"):
		if _pause_lock != null:
			_pause_lock.release()
			_pause_lock = null
		else:
			_pause_lock = PauseTree.pause()
	if Input.is_action_just_pressed(&"restart_game"):
		EngineDebugger.send_message("debug:restart_game", [])
	if OS.is_debug_build() and Input.is_action_just_pressed(&"restart_scene"):
		PauseTree.clear()
		CurrentScene.restart()
	if Input.is_action_just_pressed(&"fullscreen"):
		_toggle_fullscreen()
	if OS.is_debug_build() and Input.is_action_just_pressed(&"screenshot"):
		DirAccess.make_dir_absolute(
			ProjectSettings.globalize_path("res://screenshots")
		)
		var img := get_tree().root.get_texture().get_image()
		img.resize(1920, 1080)
		img.save_png("res://screenshots/%s.png" % Time.get_ticks_usec())


func _toggle_fullscreen() -> void:
	if get_window().mode != Window.MODE_FULLSCREEN:
		get_window().mode = Window.MODE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED
