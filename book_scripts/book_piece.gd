extends Node3D
class_name BookPiece

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

func _ready():
	# setup modulate for colours
	setup()
	pass

# function for drag and drop in ruins
func _unhandled_input(event):
		if in_ruins:
			if event is InputEventMouseMotion:
				var currentCamera = get_viewport().get_camera_3d()
				var params = PhysicsRayQueryParameters3D.new()
				params.from = currentCamera.project_ray_origin(event.position)
				params.to = currentCamera.project_position(event.position,1000)
				var worldspace = get_world_3d().direct_space_state
				world_mouse_pos = worldspace.intersect_ray(params)

func _process(delta):
	
	# drag and drop for ruins
	if dragable:
		if Input.is_action_just_pressed("click") && InventorySystem.is_dragging == null:
			initialPos = global_position
			InventorySystem.is_dragging = self
		if Input.is_action_pressed("click") && InventorySystem.is_dragging == self:
			if !world_mouse_pos.is_empty():
				global_position = world_mouse_pos["position"] + Vector3(0,0.5,0)
		pass
		if Input.is_action_just_released("click"):
			var tween = get_tree().create_tween()
			print(tween)
			InventorySystem.is_dragging = null
			dragable = false
			if is_inside_dropable:
				tween.tween_property(self, "global_position",body_ref.global_position+Vector3(0,0.5+(InventorySystem.in_cart*0.5),0),0.2)
				InventorySystem.put_in_cart(self)
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
			$Sprite3D.modulate = Color.BLUE
		colour.Types.RED:
			$Sprite3D.modulate = Color.RED
		colour.Types.YELLOW:
			$Sprite3D.modulate = Color.YELLOW
		colour.Types.GREEN:
			$Sprite3D.modulate = Color.GREEN
		_:
			$Sprite3D.modulate = Color.PINK
	pass

# check if mouse is on book
func _on_area_3d_mouse_entered():
	if InventorySystem.is_dragging == null && !in_cart && InventorySystem.in_cart <3:
		dragable = true
		scale = Vector3(1.05,1.05,1.05)
	pass 

func _on_area_3d_mouse_exited():
	if InventorySystem.is_dragging != self:
		dragable = false
		scale = Vector3(1,1,1)
	pass 

# check if book is on cart
func _on_area_3d_area_entered(area):
	print("Entered a area")
	if area.is_in_group("dropable"):
		is_inside_dropable = true
		body_ref = area
		print("In the area")
		pass
	pass 

func _on_area_3d_area_exited(area):
	if area.is_in_group("dropable"):
		is_inside_dropable = false
	pass
