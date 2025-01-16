class_name ParticlesPool2D


class Base extends Node:
	var _scene: Object
	var _ready_particles: Array[Node]
	
	## scene: SceneSource | PackedScene
	func _init(scene: Object, lifetime_owner: Node) -> void:
		_scene = scene
		lifetime_owner.add_child(self)
	
	func _notification(what: int) -> void:
		if what == NOTIFICATION_PREDELETE:
			dispose()
	
	func dispose() -> void:
		for p in _ready_particles:
			p.queue_free()
		_ready_particles.clear()
	
	func get_one() -> Variant:
		if len(_ready_particles) > 0:
			return _ready_particles.pop_back()
		else:
			var particles := _instantiate()
			particles.connect("finished", func() -> void:
				utils.unparent(particles)
				_ready_particles.append(particles)
			)
			return particles
	
	func _instantiate() -> Node:
		return _scene.instantiate()


class CPU extends Base:
	func get_one() -> CPUParticles2D:
		return super.get_one()


class GPU extends Base:
	func get_one() -> GPUParticles2D:
		return super.get_one()
