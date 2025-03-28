extends Node2D
class_name PlayArea

# Data used to initialize this node and children nodes (zones for now but others likely included)
var init_data: Dictionary
# True if player is able to manipulate stuff on this area freely (can iron out details later)
var usable_by_player := false

@onready var background = $Background

func _init() -> void:
	pass

func _ready() -> void:
	pass
