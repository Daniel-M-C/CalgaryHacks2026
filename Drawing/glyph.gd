class_name Glyph
extends Line2D

"""
TrueGlyph should be invisible, and is what will be used to evaluate with.
Could try to do a slice of which are being matched currently
"""

@onready var true_glyph: Line2D = $TrueGlyph
@onready var draw_pos : Vector2 =  Vector2.ZERO


@onready var glyphs : Array[GlyphArr] = [
	preload("res://Drawing/Glyphs/feather.tres"),
	preload("uid://c7n7ngoyu0vgk")
]

# NOTE :
# ensure this matches up with the above list
enum GLYPH_NAME {
	FEATHER,
	VULTURE
}

@export var curr_glyph : GLYPH_NAME = 0


func _ready() :
	points = glyphs[curr_glyph].arr
	
	true_glyph.points = glyphs[curr_glyph].arr
	#TODO make true_glyph invisible when not testing.
	# maybe wait until until the first point to give a hint on where
	# to start
	#true_glyph.visible = false
	
	# have to wait a frame for the parent to set this
	await get_tree().process_frame
	true_glyph.position = draw_pos
	pass
		

func evaluate(other : PackedVector2Array, slice: Array = []) -> float:
	"""
	other : arr of drawn points to compare to
	slice : which points to compare to at the moment.
	
	Returns a score (0, inf) = mean_closest_dist_from_points/difficulty
	1 = expected value (ok)
	< 1 = good 
	> 1 = worse
	
	of how close the drawing is to glyph.
	"""
	var total_dist : int = 0
	var n_points : int = 0
	
	if other.size() == 0 :
		printerr("NO DRAWING PROVIDED")
		return -1 
	
	
	#TODO handle slices
	# for each point on true
	for point in true_glyph.points :
		
		pass
		# find the closest point on other,
		# TODO that isn't already paired with something else
		# use bsearch here??
		n_points += 1
		var closest_dist : float = 100_000_000 # this is arbitrary
		var dist : float
		var points_in_o : int
		var min_point : int
		for o_point in other :
			points_in_o += 1
			dist = point.distance_squared_to(o_point)
			if dist < closest_dist :
				closest_dist = dist
				min_point = points_in_o
		total_dist += closest_dist
			# pair it with this, score on distance.
		
	# return average score by some multiplier.
	total_dist = total_dist/n_points
	#TODO may have to scale to screen size
	return sqrt(total_dist)/glyphs[curr_glyph].difficulty
