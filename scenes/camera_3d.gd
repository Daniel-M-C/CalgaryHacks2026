extends Camera3D

@onready var look_target: Node3D = %PlayerChar.get_child(0)
@onready var target_direction: Node3D = $"../TargetDirection"
@export var look_speed := 5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	target_direction.look_at(look_target.position)
	self.rotation = self.rotation.lerp(target_direction.rotation, look_speed * delta)
	pass
