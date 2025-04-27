extends Node
class_name MouseDetector

enum ResizingTypes{
	FIXED_SIZE, PARENT_SPRITE
}

@export var size_type := ResizingTypes.PARENT_SPRITE
@export_group("Padding")
@export var left: float
@export var right: float
@export var top: float
@export var bottom: float

# Rect which covers where the sprite is on the object. Used to check if point inside rect.
var rect := Rect2()
# If true mouse is on object. Will respect z index (objects below mouse with lesser z index have this false)
var mouse_on := false

var rect_area: Sprite2D = null

signal add_to_mouse_on_list(detector)

func _ready() -> void:
	if not get_parent() is Sprite2D: # This makes sure this node is only used for Sprites (needs stuff from sprite)
		printerr("Attempted to add mouse detector to a non sprite node (%s). Removing now." % get_parent().name)
		queue_free()
	update_rect()
	print("z index of {0}: {1}".format([get_parent().name, MouseDetectHandler.get_actual_z_index(get_parent())]))
	

func _process(delta: float) -> void:
	pass
	
# Updates rect for detecting if mouse is on this object
func update_rect() -> void:
	var t_size = get_parent().texture.get_size()
	rect.position = get_parent().position - Vector2(left, top)
	rect.size = t_size - Vector2(left + right, top + bottom)
