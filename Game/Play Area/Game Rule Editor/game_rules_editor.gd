extends Node2D

@onready var base_context_menu = $"CanvasLayer/Base Context Menu"

func _on_base_context_menu_id_pressed(id: int) -> void:
	match id:
		0:
			print("make new Play Area")
		1:
			print("make new zone")
