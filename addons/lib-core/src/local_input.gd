@icon("uid://cs7qb520wygvg")
class_name LocalInput
extends Control


signal just_pressed
signal just_released
signal pressed
signal echo
signal just_pressed_or_echo

@export var shortcut: Shortcut
@export_flags("Input:1", "GuiInput:2", "UnhandledInput:4") var mode: int

var _pressed: bool


func _ready() -> void:
	#mouse_filter = MOUSE_FILTER_IGNORE
	just_pressed.connect(just_pressed_or_echo.emit)
	echo.connect(just_pressed_or_echo.emit)


func _unhandled_input(event: InputEvent) -> void:
	if _has_flag(4):
		_handle_event(event)


func _input(event: InputEvent) -> void:
	if _has_flag(1):
		_handle_event(event)


func _gui_input(event: InputEvent) -> void:
	if _has_flag(2):
		_handle_event(event)


func _handle_event(event: InputEvent) -> void:
	if shortcut.matches_event(event):
		if event.is_pressed():
			if not _pressed:
				just_pressed.emit()
			pressed.emit()
			_pressed = true
		else:
			if _pressed:
				just_released.emit()
				_pressed = false
		if event.is_echo():
			echo.emit()


func _has_flag(flag: int) -> bool:
	return mode & flag
