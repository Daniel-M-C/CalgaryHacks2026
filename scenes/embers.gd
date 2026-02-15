extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var embers = self.get_children()
    for ember in embers:
        ember.visible = true
    pass # Replace with function body.
