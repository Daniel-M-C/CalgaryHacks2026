extends Node

# ensure glyph.gd matches that stuff
enum GLYPH_NAME {
	FEATHER,
	VULTURE,
	EYE,
	WING,
}

const CAMERA_DEMO_SCENE = preload("uid://d3vaj5uewf5uj")
const COLLECTION_DEMO = preload("uid://y0pktn0crjwr")
const MODELS_ATMOSPHERE_DEMO_SCENE = preload("uid://cmhurp5l43uyp")
const MAIN_MENU = preload("uid://8k2t8n78y7n")


func _input(event):
	if event.is_action_pressed("1"):
		get_tree().change_scene_to_packed(MODELS_ATMOSPHERE_DEMO_SCENE)
	if event.is_action_pressed("2"):
		get_tree().change_scene_to_packed(CAMERA_DEMO_SCENE)
	if event.is_action_pressed("3"):
		get_tree().change_scene_to_packed(COLLECTION_DEMO)
	if event.is_action_pressed("4"):
		get_tree().change_scene_to_packed(MAIN_MENU)
	if event.is_action_pressed("5"):
		pass
		#get_tree().change_scene_to_packed(MODELS_ATMOSPHERE_DEMO_SCENE)
	if event.is_action_pressed("6"):
		pass
		#get_tree().change_scene_to_packed(MODELS_ATMOSPHERE_DEMO_SCENE)
	
		
		
		
		
		
