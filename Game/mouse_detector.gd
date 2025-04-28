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

# Current viewport (so I dont have to keep calling get_viewport() repeatingly)
@onready var viewport := get_viewport()

# Rect which covers where the sprite is on the object. Used to check if point inside rect.
var rect := Rect2()
# If true mouse is on object. Will respect z index (objects below mouse with lesser z index have this false)
var mouse_on := false
# True if mouse is on the object in some way. Used to determin method to call for mouse detect handler
var mouse_on_rect := false : set = _set_mouse_on_rect

var rect_area: Sprite2D = null

signal add_to_mouse_on_list(detector)

func _ready() -> void:
	if not get_parent() is Sprite2D: # This makes sure this node is only used for Sprites (needs stuff from sprite)
		printerr("Attempted to add mouse detector to a non sprite node (%s). Removing now." % get_parent().name)
		queue_free()
	update_rect()
	#print("z index of {0}: {1}".format([get_parent().name, MouseDetectHandler.get_actual_z_index(get_parent())]))
	

func _process(delta: float) -> void:
	mouse_on_rect = rect.has_point(viewport.get_mouse_position())
	update_mouse_on_rect()
	
func _set_mouse_on_rect(value: bool) -> void:
	if value != mouse_on_rect:
		print("Node {0} = {1}".format([get_parent().name, value]))
		if value:
			MouseDetectHandler.add_under_mouse(self)
		else:
			MouseDetectHandler.remove_under_mouse(self)
	mouse_on_rect = value
		
func update_mouse_on_rect() -> void:
	var rect_has_mouse := rect.has_point(viewport.get_mouse_position())
	if mouse_on_rect != rect_has_mouse:
		mouse_on_rect = rect_has_mouse
	
# Updates rect for detecting if mouse is on this object
func update_rect() -> void:
	var parent = get_parent()
	var t_size = parent.texture.get_size() * parent.global_scale
	rect.size = t_size - Vector2(left + right, top + bottom)
	rect.position = get_parent().global_position - Vector2(left, top) - rect.size / 2
	print("updating rect of {0} with rect {1}.".format([get_parent().name, rect]))
