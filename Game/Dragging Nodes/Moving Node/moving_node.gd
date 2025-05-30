# This node is created when player wishes to drag stack and possibly other things around.
# It will basically be instantiated in for this purpose, and will appear exacly like it's master.
# Once player releases mouse button, this will send move request.

extends Sprite2D

# Sprite this will look like and will ask the server to move if needed
var master: Sprite2D

signal finished_drag(master, position)

func _ready() -> void:
	scale = master.scale
	texture = master.texture
	position = master.position
