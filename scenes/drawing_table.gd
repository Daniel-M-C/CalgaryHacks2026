extends Node3D

@export var drawing_scene : DrawingTablet
@onready var area_3d: Area3D = $Area3D
@export var player : Player

func _ready() :
	pass
	# look for player
	await get_tree().process_frame
	# idk if this works
	if ! player :
		if len(get_tree().current_scene.find_children("", 'Player')) > 0 :
			player = get_tree().current_scene.find_children("", 'Player')[0]

	if ! drawing_scene :
		if len(get_tree().current_scene.find_children("", 'DrawingTablet')) > 0 :
			drawing_scene = get_tree().current_scene.find_children("", 'DrawingTablet')[0]

func _unhandled_input(event: InputEvent) -> void:
	pass
	if event.is_action_pressed("interact") :
		if area_3d.overlaps_body(player) :
			if drawing_scene.visible : 
				drawing_scene.visible = false
				# TODO enable movement
			else :
				drawing_scene.visible = true
				# TODO disable movement
			pass
			
