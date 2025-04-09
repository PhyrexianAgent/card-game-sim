extends Node

@export var context_menu: PopupMenu

func _input(event: InputEvent) -> void:
	if event.is_action_released("open_context"):
		context_menu.position = event.position
		context_menu.popup()
