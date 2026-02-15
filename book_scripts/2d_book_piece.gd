extends Node2D
class_name BookPiece2D

"""
Adapted from book_piece.gd 
to work in the drawing menu
"""


# pick different book types for each instance
# colour and page number in export variables
@export var colour:BookTypes

# variables for drag and drop
var in_ruins = true
var dragable = false
var is_inside_dropable = false
var body_ref
var initialPos
var world_mouse_pos
var in_cart = false

@export var starting_pos : Vector2
# true for drawing
# false for restoration
var drawing_or_restoration :bool = true 

# variables for glyphs
var glyph : Globals.GLYPH_NAME = 0 
var part_num = 0 # 0-2, need all at some point.

func _ready():
	# setup modulate for colours
	setup()
	pass

# function for drag and drop in ruins
func _unhandled_input(event):
		if in_ruins:
			if event is InputEventMouseMotion:
				#var currentCamera = get_viewport().get_camera_3d()
				#var params = PhysicsRayQueryParameters3D.new()
				#params.from = currentCamera.project_ray_origin(event.position)
				#params.to = currentCamera.project_position(event.position,1000)
				#var worldspace = get_world_3d().direct_space_state
				#world_mouse_pos = worldspace.intersect_ray(params)
				world_mouse_pos = get_global_mouse_position()

func _process(delta):
	
	# drag and drop for ruins
	if dragable:
		if Input.is_action_just_pressed("click") && InventorySystem.is_dragging_2d == null:
			initialPos = global_position
			InventorySystem.is_dragging_2d = self
		if Input.is_action_pressed("click") && InventorySystem.is_dragging_2d == self:
			#if !world_mouse_pos.is_empty():
			global_position = get_global_mouse_position()#world_mouse_pos#["position"] + Vector3(0,0.5,0)
		pass
		if Input.is_action_just_released("click"):
			var tween = get_tree().create_tween()
			print(tween)
			InventorySystem.is_dragging_2d = null
			dragable = false
			if is_inside_dropable:
				tween.tween_property(self, "global_position",body_ref.global_position+Vector2(0,0),0.2)
				#TODO is this here ???
				#TODO detect drawing or restoration
				InventorySystem.put_in_drawing_tablet(self)
				in_cart = true
				print("Going to are ref")
			else: 
				print("Going back")
				tween.tween_property(self, "global_position",initialPos,0.2)
			pass
	pass

# setup colour for specific instance
func setup():
	match colour:
		colour.Types.BLUE:
			$Sprite2D.modulate = Color.BLUE
		colour.Types.RED:
			$Sprite2D.modulate = Color.RED
		colour.Types.YELLOW:
			$Sprite2D.modulate = Color.YELLOW
		colour.Types.GREEN:
			$Sprite2D.modulate = Color.GREEN
		_:
			$Sprite2D.modulate = Color.PINK
	pass

# check if mouse is on book
func _on_area_2d_mouse_entered():
	if InventorySystem.is_dragging_2d == null : 
		dragable = true
		scale = Vector2(1.05,1.05)
	pass 

func _on_area_2d_mouse_exited():
	if InventorySystem.is_dragging_2d != self:
		dragable = false
		scale = Vector2(1,1)
	pass 

# check if book is on drawing or restoration
#TODO differentiate
func _on_area_2d_area_entered(area: Area2D) -> void:
	print("Entered a area")
	if area.is_in_group("dropable"): 
		is_inside_dropable = true
		body_ref = area
		print("In the area")
		# hide so it doesn't hide the drawing
		visible = false
	
	if area.get_parent() is Glyph :
		drawing_or_restoration = true
		# questionable if this should be called here.
		area.get_parent().change_book(self)
	else :
		drawing_or_restoration = false
	


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("dropable"):
		is_inside_dropable = false
