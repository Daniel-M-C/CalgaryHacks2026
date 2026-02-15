extends Node3D

@export var tint : Color
@onready var cover: Node3D = $Cover_Local


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var coverChildren := cover.find_children("*", "MeshInstance3D", false, false)
    for mesh3d: MeshInstance3D in coverChildren:
        mesh3d.get_active_material(0).albedo_color = tint
    pass
