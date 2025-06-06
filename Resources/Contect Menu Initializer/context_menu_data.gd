extends Resource
class_name ContextMenuData

@export var hide_from_item_selection := true
@export var hide_from_checkable_selection := true
@export var items: Array[ContextItemData]

func get_item_callables(menu: PopupMenu) -> Array[Callable]:
	var callables: Array[Callable]
	for item in items:
		callables.append(item.get_init_callable(menu))
	return callables
