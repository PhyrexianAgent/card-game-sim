extends PopupMenu

@export var initial_menu_data: ContextMenuData

func _ready() -> void:
	var item_callables = initial_menu_data.get_item_callables(self)
	for callable in item_callables:
		callable.call()
	hide_on_item_selection = initial_menu_data.hide_from_item_selection
	hide_on_checkable_item_selection = initial_menu_data.hide_from_checkable_selection
