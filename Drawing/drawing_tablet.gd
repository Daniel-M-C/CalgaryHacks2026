class_name DrawingTablet
extends Node2D

"""
Handles creating the drawing
and hosting the original glyph.
"""
@onready var base_glyph: Glyph = $BaseGlyph
@onready var drawing: Line2D = $Drawing

## How much time between points
@export var point_cooldown : float = 0.05
@export var min_point_dist : float = 10 # TODO implement this
@onready var timer: Timer = $Timer
var draw_pos : Vector2

## Sets limits to where you can draw
@onready var bounds: Node2D = $Bounds
## For placing books
@onready var book_bounds_l: Node2D = $BookBoundsL
## For placing restorations
@onready var book_bounds_r: Node2D = $BookBoundsR
## To be a parent to books
@onready var books_node: Node2D = $Books

const _2D_BOOK_PIECE = preload("uid://gi7ee2gij516")

var drawing_points : PackedVector2Array

func _ready() -> void:
	timer.wait_time = point_cooldown
	draw_pos = drawing.position
	base_glyph.draw_pos = draw_pos
	

#func _input(event: InputEvent) -> void:
func _process(delta: float) -> void :
	# catches all mouse inputs (within bounds)
	# and uses them to draw. 
	# may need to pass inputs from an area2d later or smth.
	
	
	# or just don't bother and draw anywhere, block the viz
	# range of the drawing line or smth
	
	#TODO decide on time or min distance for points
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer.is_stopped():
		
		#TODO limit range of darwing
		var pos = get_local_mouse_position()
		if pos.x > bounds.get_child(0).position.x and pos.x < bounds.get_child(1).position.x \
		and pos.y > bounds.get_child(0).position.y and pos.y < bounds.get_child(1).position.y :
			
			drawing_points.append(pos - draw_pos)
			# for some reson drawing.points immutable??? this works tho.
			drawing.points = drawing_points
			timer.start()
			base_glyph.hide_hint()
	
	pass


func _on_button_pressed() -> void:
	var score = base_glyph.evaluate(drawing.points)
	print('score =', score) 


## Called from the inventory manager on startup
func make_books(books : Array[BookTypes], restorations : Array[BookTypes]) :
	
	# Books on the left to place a reference
	for i in books :
		var new_book : BookPiece2D = _2D_BOOK_PIECE.instantiate()
		new_book.colour = i
		# place in a random position (for fun)
		books_node.add_child(new_book)
		new_book.starting_pos.x = randf_range(book_bounds_l.get_child(0).global_position.x, 
											  book_bounds_l.get_child(1).global_position.x)
		new_book.starting_pos.y = randf_range(book_bounds_l.get_child(0).global_position.y, 
											  book_bounds_l.get_child(1).global_position.y)
		new_book.position = new_book.starting_pos
	
	# restorations on the right to draw/continue drawing them
	for i in restorations :
		var new_book : BookPiece2D = _2D_BOOK_PIECE.instantiate()
		new_book.colour = i
		books_node.add_child(new_book)
		# place in a random position (for fun)
		new_book.starting_pos.x = randf_range(book_bounds_r.get_child(0).global_position.x, 
											  book_bounds_r.get_child(1).global_position.x)
		new_book.starting_pos.y = randf_range(book_bounds_r.get_child(0).global_position.y, 
											  book_bounds_r.get_child(1).global_position.y)
		new_book.position = new_book.starting_pos
		new_book.rotation_degrees = randf_range(-180, 180)
	pass
	
