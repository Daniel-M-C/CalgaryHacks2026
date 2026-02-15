extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    self.environment.set_fog_enabled(true)
