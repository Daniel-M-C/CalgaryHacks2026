class_name DrawingTable
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

@onready var bounds: Node2D = $Bounds


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
