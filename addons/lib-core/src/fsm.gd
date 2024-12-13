class_name FSM
## [codeblock]
## enum State {
##     None, 
##     Booting
## }
## 
## func _ready() -> void:
##     var fsm := FSM.new(State.None, func(fsm: FSM) -> Array[FSM.IState]:
##         return [
##             FSM.State.new(
##                 State.None
##             ).on_exit(
##                 func() -> void: print("bye!")
##             ).bind_process(
##                 func(delta: float) -> void: print("process %s" % delta)
##             ),
##             
##             FSM.State.new(
##                 State.Booting, 
##                 func(booting: FSM.State) -> void:
##                     booting.on_enter(
##                         func() -> void: print("hello!")
##                     )
##                     booting.bind_process(func(delta: float) -> void:
##                         print("process %s" % delta)
##                     )
##                     \
##             )
##         ]
##     )
##     
##     fsm.go_to(State.Booting)
##     fsm.process(delta)
## [/codeblock]


var _default_state: IState
var _prev_state: IState
var _current_state: IState
var _states: Dictionary = {}


func _init(null_id: Variant, ctor: Callable) -> void:
	var states = ctor.call(self)
	for state in states:
		assert(state.id() not in _states)
		_states[state.id()] = state
	
	_default_state = _get_state_by_id_or_null(null_id)
	if _default_state == null:
		_default_state = StateNull.new()
	_current_state = _default_state
	_prev_state = _default_state


func get_bind(bind_type: Script) -> Variant:
	return _current_state.get_bind(bind_type)


func inspect_bind(bind_type: Script, inspect: Callable) -> void:
	var bind := get_bind(bind_type)
	inspect.call(bind)


## shortcut for. may became built-in in the future
## [codeblock]
##var bind: FSM.BProcess = get_bind(BProcess)
##if bind != null:
##    bind.invoke(delta)
## [/codeblock]
func process(delta: float) -> void:
	var bind: BProcess = get_bind(BProcess)
	if bind != null:
		bind.invoke(delta)


func back() -> void:
	_change_state(_prev_state)


func reset() -> void:
	_change_state(_default_state)


func go_to(state_id: Variant) -> void:
	var state := _get_state_by_id_or_null(state_id)
	assert(state != null, "state %s was not found" % state_id)
	_change_state(state)


func _get_state_by_id_or_null(state_id: Variant) -> IState:
	var state = _states.get(state_id)
	return state


func _change_state(state: IState) -> void:
	_current_state.exit()
	_prev_state = _current_state
	_current_state = state
	_current_state.enter()


class IState:
	func id() -> Variant:
		return null
	
	func get_bind(bind_type: Script) -> Variant:
		return null

	func enter() -> void:
		pass
	
	func exit() -> void:
		pass


class StateNull extends IState:
	pass


class State extends IState:
	var _id: Variant
	var _on_enter := func(): pass
	var _on_exit := func(): pass
	var _binds: Dictionary = {}
	
	func _init(id: Variant, build: Callable = func(_this): pass) -> void:
		_id = id
		build.call(self)
	
	func id() -> Variant:
		return _id
	
	func enter() -> void:
		_on_enter.call()
	
	func exit() -> void:
		_on_exit.call()

	func get_bind(bind_type: Script) -> Variant:
		return _binds.get(bind_type)

	func bind(bind: Object) -> State:
		var script := bind.get_script()
		assert(script != null, "bind script is null!")
		assert(script not in _binds, "bind is already bound")
		_binds[script] = bind
		return self
	
	func bind_process(callable: Callable) -> State:
		return self.bind(BProcess.new(callable))
	
	func on_enter(callable: Callable) -> State:
		_on_enter = callable
		return self

	func on_exit(callable: Callable) -> State:
		_on_exit = callable
		return self


## B - Bind
class _BCallable:
	var _callable: Callable
	
	func _init(callable: Callable) -> void:
		_callable = callable


class BProcess extends _BCallable:
	func invoke(delta: float) -> void:
		_callable.call(delta)
