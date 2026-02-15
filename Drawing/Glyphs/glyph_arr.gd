class_name GlyphArr
extends Resource

## We need to have one array for each possible segment
## We can make just one to begin with (since that makes drawing easier)
## Then separate them through parts.
## Then Glyph can make a Line2D for each part
@export var arr : PackedVector2Array 

## Used to determine score of drawings.
## score = mean_closest_dist_from_points/difficulty
@export var difficulty : float = 100


## An array of array of ints
## Each glyph is split into several parts
## [part_index][n_point_of_part]
@export var parts : Array = [
	[0,1,2,3,4,5],
	[6,7,8,9,10,11],
	[12,13,14,15,16,17]
]
