class_name Glyph
extends Line2D

"""
TrueGlyph should be invisible, and is what will be used to evaluate with.
Could try to do a slice of which are being matched currently
"""

@onready var true_glyph: Line2D = $TrueGlyph
@onready var draw_pos : Vector2 =  Vector2.ZERO

@export var curr_book : BookPiece2D

# NOTE :
# ensure this matches up with the global list of glyph names
@onready var glyphs : Array[GlyphArr] = [
	preload("res://Drawing/Glyphs/feather.tres"),
	preload("uid://c7n7ngoyu0vgk"),
	preload("uid://btpk3n767ossy"),
	preload("uid://btm5gdnauohfu")
]


@export var curr_glyph : Globals.GLYPH_NAME = Globals.GLYPH_NAME.EYE

## Has to be lower than the max number of parts for the curr_glyph
## just do it right, I don't want to remember
@export var curr_part : int = 0

var parts : Array[Line2D] = []

func _ready() :
	points = glyphs[curr_glyph].arr
	
	#true_glyph.points = glyphs[curr_glyph].arr
	#TODO make true_glyph invisible when not testing.
	# maybe wait until until the first point to give a hint on where
	# to start
	#true_glyph.visible = false
	
	# have to wait a frame for the parent to set this
	await get_tree().process_frame
	true_glyph.position = draw_pos
	# fix scaling since it's not at the right screen resolution anymore.
	true_glyph.position.y -= position.y * get_parent().scale.y
	true_glyph.position.x += position.x * get_parent().scale.x
	draw_pos = true_glyph.global_position
	pass
	
	# we're just defaulting to everything, tho it can be changed later
	if parts == [] :
		set_parts()#([0,1,2,3,4,5,6,7,8,9,10])
		pass
	
func set_parts() : #new_parts : Array[int]) :
	"""
	Uses curr_part to select which to draw.
	Has to be lower than the max number of parts for the curr_glyph
	just do it right, I don't want to make this work properly.
	Over max will be ignored
	
	
	Points are added to true_glyph just for convenience. They are
	re added in evaluate to do it on all points
	"""
	
	# delete old parts
	for i : Line2D in parts :
		i.queue_free()
	
	parts = []
	
	for i in true_glyph.get_children() :
		i.queue_free()
	
	# Making all the lines :
	
	# Current thing will only have one 
	
	# Glyph is made of several parts
	# we need to make all of them as children, then
	# set everything there.
	#for i in new_parts : #glyphs[curr_glyph].parts :
	
	# don't want to over index
	#if i < len(glyphs[curr_glyph].parts) :
	# to here
	var new_line : Line2D = Line2D.new()
	var new_line_2 : Line2D = Line2D.new()

	for point in glyphs[curr_glyph].arrs[curr_part] : #range(glyphs[curr_glyph].parts[max(0, i-1)] - 1, glyphs[curr_glyph].parts[i]) :
		new_line.add_point(point)#glyphs[curr_glyph].arr[point])
		add_child(new_line)
		
		# to true_glyph
		new_line_2.add_point(point)#glyphs[curr_glyph].arr[point])
	parts.append(new_line)
	true_glyph.add_child(new_line_2)

	# we then set which is active when told through set_part
	#curr_parts = new_parts
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
	# Adding all points to true_glyph
	var new_line : Line2D = Line2D.new()
	# don't want to index -1
	# tho it actually may work fine, idk.                    - 1 to have overlap
	for part in glyphs[curr_glyph].arrs :
		for point in part : 
			new_line.add_point(point)
	true_glyph.add_child(new_line)
		
	
	# end adding
	
	
	
	
	var total_dist : int = 0
	var n_points : int = 0
	
	if other.size() == 0 :
		printerr("NO DRAWING PROVIDED")
		return -1 
	
	
	#TODO handle slices
	# for each point on true
	for line in true_glyph.get_children() :
		for point in line.points :
			
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
	total_dist = total_dist/(n_points + 1)
	return sqrt(total_dist)/glyphs[curr_glyph].difficulty


func hide_hint() :
	true_glyph.visible = false
	
func change_book(new_book : BookPiece2D) :
	# change curr_line and piece
	curr_glyph = new_book.colour.glyph
	# TODO this may have to change
	curr_part = new_book.colour.piece_num
	
	# chnage back so we can re select it if we want to.
	if curr_book :
		curr_book.visible = true
	curr_book = new_book
	
	points = []
	# TODO set to actual things
	set_parts()#([0,1,2,3,4,5,6,7,8,9,10])
	pass
