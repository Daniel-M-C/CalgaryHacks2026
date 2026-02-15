class_name GlyphArr
extends Resource

"""
Override :
	You set three different arrays, one for each third of the book you can find
	it should all work :/

How to add and modify glyphs :
	
1. make a new glyph resource
2. Set the arr : PackedVector2Array to the right shape
	(can paint one with a line2d, then copy paste it from the .tscn to the .res)
3. Set the parts array (most will be in three parts). See var parts
4. Add the preload to glyph.gd glyphs and the globals enum

done. Yay ^_^
"""

## We need to have one array for each possible segment
## We can make just one to begin with (since that makes drawing easier)
## Then separate them through parts.
## Then Glyph can make a Line2D for each part
# should be ignored, use arrs
@export var arr : PackedVector2Array 

## We need to have one array for each possible segment
## This will be 3 for all. Should separate along the same lines so we can
## use the same burnt paper/borken clay sprite for the backgrounds.
@export var arrs : Array[PackedVector2Array]

## Used to determine score of drawings.
## score = mean_closest_dist_from_points/difficulty
@export var difficulty : float = 100


## Each glyph is split into several parts
## starts at 0, goest to [1],
## then from [1] to [2] and so forth
## will be inclusive of the beginning to keep overlap
## and have the lines touch 

# should be ignored
# current active part is stored in BookTypes
# and handled by glyph.gd
@export var parts : Array[int] = []
