extends EditorDebuggerPlugin


func _has_capture(capture: String) -> bool:
	return capture == "debug"


func _capture(message: String, data: Array, session_id: int) -> bool:
	if message == "debug:restart_game":
		var path := EditorInterface.get_playing_scene()
		EditorInterface.stop_playing_scene()
		
		var wait_time := 0.0
		var tree := EditorInterface.get_base_control().get_tree()
		for i in range(100):
			await tree.create_timer(wait_time).timeout
			if not EditorInterface.is_playing_scene():
				break
			wait_time += 1.0
			print("Waiting for Editor to stop playing scene...")

		if ProjectSettings.get_setting("application/run/main_scene") == path:
			EditorInterface.play_main_scene()
		else:
			EditorInterface.play_custom_scene(path)

		return true
	return false
