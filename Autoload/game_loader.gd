extends Node

# Where non default game rules are stored in appdata.
const GAME_RULES_PATH := "user://Game-Rules"
# Where decks users make would be saved. Decks will be futher sorted by folders Game Rules specify.
const DECK_PATH := "user://Decks"
# Json format extension
const JSON_EXTENSION := ".json"

# Stores all game rules when game starts. Default rules also go here because when game is exported,
# the files may be in a form that only resource loader can properly handle.
var game_rules := []

func _ready() -> void:
	pass

# Gets files in folder path and passes them to func that will open them all
func get_rules_in_folder(folder_path: String) -> void:
	var dir = DirAccess.open(folder_path)
	if dir:
		get_rules_from_files(dir.get_files(), folder_path)
	else:
		printerr("Unable to open folder at path %s" % folder_path)
		
# Opens files in the array, gets the string data from them, and makes them into dictionaries for game rules
func get_rules_from_files(file_names: PackedStringArray, folder_path: String) -> void:
	for file_name in file_names:
		var file_data := FileAccess.get_file_as_string(folder_path + "/" + file_name)
		var json = JSON.parse_string(file_data)
		game_rules.append(json.data)
