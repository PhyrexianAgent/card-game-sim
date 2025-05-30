extends Sprite2D

enum DragTypes{
	NEVER,
	ONLY_TOP_CARD,
	WHOLE_STACK
}

# This node will be the stack object in game. Name will be id of stack for now (will change if that
# does not work as intended)

# Defualt card back used for players (will have players able to change via settings in future)
@export var card_back: Texture2D
# Determines type of behaviour used when player is dragging stack
@export var drag_type: DragTypes = DragTypes.ONLY_TOP_CARD
# Distance needed to be considered being dragged
@export var minimun_drag_start_distance: float = 5

@onready var mouse_detector = $"Mouse Detector"

# Will make stack stuff hidden from players and allows card preview to be used.
var is_hidden := false : set = _set_is_hidden
# Number of cards in stack (default is 1)
var card_count: int = 1

# Will set the texture of stack to image and make stack not hidden
func set_front_image(image: Image) -> void:
	var texture: ImageTexture
	texture.create_from_image(image)
	is_hidden = false
	self.texture = texture

func _set_is_hidden(value: bool) -> void:
	if not is_hidden and value and is_inside_tree():
		texture = card_back
	is_hidden = value
	
func _ready() -> void:
	if is_hidden:
		texture = card_back
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("drag_camera") and mouse_detector.mouse_on and not DraggingLayer.instance.is_dragging:
		DraggingLayer.instance.start_drag(self)
