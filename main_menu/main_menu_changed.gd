extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_start_pressed() -> void:
	InventorySystem.set_music()
	get_tree().change_scene_to_file("res://scenes/DemoScenes/ModelsAtmosphereDemoScene.tscn")

	
func _on_options_pressed() -> void:
	pass

func _on_exit_pressed() -> void:
	pass
