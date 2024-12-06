extends Node


var INSTANT_TRANSITION: SceneTransition = SceneTransition.Instant.new()
var _restart: Restart
var _pause_lock


func change_to(path: String, transition: SceneTransition=INSTANT_TRANSITION, args: Dictionary={}):
	_save_restart_data(path, args)
	_pause_tree()
	transition.add_to(self)
	await get_tree().process_frame
	transition.fade_in(func():
		var load = LoadInteractive.new(path)
		add_child(load)
		
		load.loaded.connect(func(scene):
			get_tree().change_scene_to_packed(scene)
			await get_tree().process_frame
			var finish = func():
				transition.fade_out(func(): _unpause_tree())
			if _current_scene_is_setup_able():
				get_tree().current_scene.setup(args, finish)
			else:
				finish.call()
		)
	)


func restart(transition=INSTANT_TRANSITION):
	if _restart != null:
		_restart.do(transition)


func _save_restart_data(path, args):
	_restart = Restart.new()
	_restart.path = path
	_restart.args = args
	_restart.current_scene = self


func _pause_tree():
	_pause_lock = PauseTree.pause()


func _unpause_tree():
	_pause_lock.release()


func _current_scene_is_setup_able():
	var current_scene = get_tree().current_scene
	return current_scene.has_method("setup")


class Restart:
	var path: String
	var args
	var current_scene
	
	func do(transition):
		current_scene.change_to(path, transition, args)



class LoadInteractive extends Node:
	signal loaded(resource: Resource)
	signal failed
	
	var _load_time = 0.0
	var _path: String
	var _progress: Array = []
	
	func _init(path):
		_path = path
	
	func _enter_tree():
		ResourceLoader.load_threaded_request(_path)

	func _process(delta):
		_load_time += delta
		var status = ResourceLoader.load_threaded_get_status(_path, _progress)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			loaded.emit(ResourceLoader.load_threaded_get(_path))
			queue_free()
		elif status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			pass
		else:
			failed.emit()
			queue_free()
