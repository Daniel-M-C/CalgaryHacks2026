extends Resource
class_name BookTypes

enum Types {
	BLUE,
	RED,
	YELLOW,
	GREEN
}
@export var currentType:Types

## Which part of the glyph.
## Ignored for restorations (completed books)
@export var piece_num := 3
@export var glyph : Globals.GLYPH_NAME = 0

@export var is_restoration := false
## Only used for restorations.
## Keeps track of what has already been drawn.
var drawn_points : Array[PackedVector2Array]

var max_num_of_pieces = 1

func _ready():
	set_type()
	piece_num = clamp(piece_num,1,max_num_of_pieces)
	pass

func set_type():
	match currentType:
		Types.BLUE:
			max_num_of_pieces = 3
		Types.RED:
			max_num_of_pieces = 2
		Types.YELLOW:
			max_num_of_pieces = 1
		Types.GREEN:
			max_num_of_pieces = 2
	pass
