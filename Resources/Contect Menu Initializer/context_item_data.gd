extends Resource
class_name ContextItemData

enum Types{
	NORMAL, CHECK_BOX, RADIO_BUTTON, SEPERATOR
}

@export var type: Types = Types.NORMAL
@export var text: String
@export var id: int

func get_init_callable(menu: PopupMenu) -> Callable:
	var callable = get_base_callable(menu)
	if type != Types.SEPERATOR:
		callable = callable.bind(text, id)
	return callable
	
func get_base_callable(menu: PopupMenu) -> Callable:
	var callable: Callable
	match type:
		Types.NORMAL:
			callable = menu.add_item
		Types.CHECK_BOX:
			callable = menu.add_check_item
		Types.RADIO_BUTTON:
			callable = menu.add_radio_check_item
		Types.SEPERATOR:
			callable = menu.add_separator
	return callable
