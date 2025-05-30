# This layer is where drag objects are created from (objects wishing to be dragged will ask this node to 
# handle it). It will also call other drag related stuff when needed.

extends CanvasLayer
class_name DraggingLayer

static var instance: DraggingLayer

# Drag node that will be instanced
@export var drag_node: PackedScene

# For other nodes to easily check if something is being dragged.
var is_dragging := false

signal starting_drag
signal ending_drag

func _ready() -> void:
	instance = self
	if DragModulate.instance != null:
		ending_drag.connect(DragModulate.instance._end_drag)
		starting_drag.connect(DragModulate.instance._start_drag)
	starting_drag.connect(func() -> void: is_dragging = true)
	ending_drag.connect(func() -> void: is_dragging = false)
	
# Will start dragging a card by making a new drag node and emiting starting drag signal
func start_drag(master: Sprite2D) -> void:
	var dragging_node = drag_node.instantiate()
	dragging_node.master = master
	dragging_node.finished_drag.connect(end_drag)
	add_child(dragging_node)
	starting_drag.emit()
	
# Will end the drag by sending http request for a card move and sending end drag signal
func end_drag(master: Sprite2D, position: Vector2) -> void:
	print("sending {0} to {1}".format([master.name, position]))
	
	ending_drag.emit()
