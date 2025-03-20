extends Resource
class_name Zone

# Is the resource that stores how a card zone will operate. This resource will be less often extended,
# but can be when needed. Exported values here will be settings per zone for game formats. When game
# starts, zones will be generated based off the values specified here.

const VISIBLE_TO_ALL = 0
const VISIBLE_TO_OWNER = 1
const VISIBLE_TO_NONE = 2

# Decides how cards are visible when sent to this zone.
@export_enum("Visible to All", "Visible to Owner", "Visible to None") var visibility_in_zone: int
# Size of zone when it will be generated
@export var size: Vector2
# Position of zone when it generates
@export var position: Vector2
# Offset for placing cards in the zone (if for whatever reason an offset is required)
@export var card_placement_offset: Vector2
# Set if image or color to be used for area
@export_enum("Image", "Color") var back_type
@export var back_image: Image
@export var back_color: Color

# Rect for detecting if player dragged card to this zone (generated when game starts)
var rect: Rect2
