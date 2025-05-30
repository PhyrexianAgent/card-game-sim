extends CanvasModulate
class_name DragModulate

static var instance: CanvasModulate

@onready var anim = $AnimationPlayer

func _ready() -> void:
	instance = self
	if DraggingLayer.instance != null:
		DraggingLayer.instance.starting_drag.connect(_start_drag)
		DraggingLayer.instance.ending_drag.connect(_end_drag)
		print("modoulate found layer")
	
func _start_drag() -> void:
	anim.play("starting_card_drag")
	
func _end_drag() -> void:
	anim.play("ending_card_drag")
