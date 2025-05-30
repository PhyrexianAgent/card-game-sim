# This node is created when player wishes to drag stack and possibly other things around.
# It will basically be instantiated in for this purpose, and will appear exacly like it's master.
# Once player releases mouse button, this will send move request.

extends Sprite2D

# Sprite this will look like and will ask the server to move if needed
var master: Sprite2D
var mouse_diff: Vector2

signal finished_drag(master, position)

func _ready() -> void:
	global_scale = master.global_scale
	texture = master.texture
	global_position = master.global_position
	modulate = master.modulate
	mouse_diff = get_global_mouse_position() - global_position
	
func _input(event: InputEvent) -> void:
	if event.is_action_released('drag_camera'):
		finished_drag.emit(master, global_position)
		queue_free()
		
func _process(delta: float) -> void:
	global_position = get_global_mouse_position() - mouse_diff
