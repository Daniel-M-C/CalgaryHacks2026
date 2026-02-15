extends Node2D

var collectables:Array = [Area2D]
@onready var label:Label = $Label
var item_collected:int = 0;
var max_item:int = 0
func _ready() -> void:
	for child in get_children():
		if child is Area2D:
			max_item += 1
			collectables.append(child)
			child.body_entered.connect(_on_body_entered)
			
	label.text =  str(item_collected) +"/"+str(max_item) 
			
func _on_body_entered(body):
	item_collected += 1
	label.text =  str(item_collected) +"/"+str(max_item) 
