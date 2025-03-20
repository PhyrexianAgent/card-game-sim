extends Resource
class_name PlayArea

# This is meant to be the area a player will 'own' where their stuff will reside. Similar to how
# Tabletop Simulator does it, there will be limited number of these, one per possible player. Any
# play area not assigned to a player will not spawn any assets into the game (being empty). I will
# do it this way for now becuase it allows us to also make a play area anyone can access and use. It
# also makes figuring out who owns what a bit easier.

# Below are basic zones a play area will have (can be left blank, making nothing spawn)
@export var deck_zone: Zone
@export var hand_zone: Zone
# If true will require a player to be an owner. Otherwise will always spawn and can be used by anyone.
@export var can_be_owned := true
# Size of play area
@export var size: Vector2
# Position of play area
@export var position: Vector2
# Set if image or color to be used for area
@export_enum("Image", "Color") var back_type
@export var back_image: Image
@export var back_color: Color

# This is a dummy type variable for however we decide to store player's id (string for now)
var owner_id: String
# Is the rect for the play area to decide if mouse pos was in play area (generated when game starts)
var rect: Rect2
