# This node is created when player wishes to drag stack and possibly other things around.
# It will basically be instantiated in for this purpose, and will appear exacly like it's master.
# Once player releases mouse button, this will send move request.

extends Sprite2D

# Sprite this will look like and will ask the server to move if needed
var master: Sprite2D
# The initial difference between mouse position and object's position
var mouse_diff: Vector2
# To only need to get the current camera once.
var camera: Camera2D
# The actual position to send the object to. This is needed as with an added camera, I need the camera's
# viewport to get proper mouse position, but oddly when using that it makes the moving node go to an improper
# position.
var actual_position: Vector2

signal finished_drag(master, position)

func _ready() -> void:
	global_scale = master.global_scale
	texture = master.texture
	global_position = master.global_position
	modulate = master.modulate
	camera = get_viewport().get_camera_2d()
	mouse_diff = camera.get_global_mouse_position() - global_position
	copy_visible_children()
	
func _input(event: InputEvent) -> void:
	if event.is_action_released('drag_camera'):
		finished_drag.emit(master, actual_position)
		queue_free()
		
func _process(delta: float) -> void:
	global_position = get_global_mouse_position() - mouse_diff
	actual_position = camera.get_global_mouse_position() - mouse_diff
	
# Will copy children of sprite that are visible (sprites for now but will include others when needed)
func copy_visible_children(sprite: Sprite2D = master, current_parent = self) -> void:
	for child in sprite.get_children():
		if child is Sprite2D:
			var child_copy = Sprite2D.new()
			child_copy.name = child.name
			child_copy.position = child.position
			child_copy.scale = child.scale
			child_copy.texture = child.texture
			child_copy.modulate = child.modulate
			current_parent.add_child(child_copy)
			if child.get_child_count() > 0:
				copy_visible_children(child, child_copy)
