extends Resource
class_name GameFormat

# This resource will store how a game format will work (any game format will extend this resource).
# I think we have the format be sent to the server in text form. When a player joins the lobby, the
# format id will be sent to the player so they can check if they have it. If not they will get the text
# form of the format. The client will then save the format in appdata, then load the saved file as the
# format resource. Exported values are stuff the player can change in settings for the format. Anything
# else will be something unchanable within the format. Base included formats will be stored in the
# project itself (like the base mtg format), otherwise user formats will be stored in appdata. Since
# code is stored per resource, if someone wishes to make a new type of game format, they only need to
# use Godot to make a new resource for the format, then store it within appdata.

# Id of the format.
var format_id := "Base-Format"

# The image used when a card is hidden
@export var hidden_image: Image

func move_card() -> void:
	pass
	
func rotate_card() -> void:
	pass

func view_card() -> void:
	pass
	
func flip_card() -> void:
	pass
