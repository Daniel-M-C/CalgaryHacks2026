extends Node3D

@onready var player: Node3D = %Player
@onready var camera_pivot: Node3D = $"Path3D/PathFollow3D/Camera Pivot"
@onready var path: Path3D = $Path3D

@export var min_follow_distance : float = 5
@export var follow_speed : float = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Find closet point on path
	var closest_point = path.curve.get_closest_point(path.to_local(player.global_position))
	
	# Find closest path offset to closest point
	var offset = path.curve.get_closest_offset(closest_point)
	
	# Setting PathFollow3D progress based off of the closest point
	var progress = path.get_child(0).progress
	var current_dist = closest_point.distance_to(player.global_position)
	# Closest point is far enough away from player
	if current_dist > min_follow_distance:
		path.get_child(0).progress = lerp(progress, offset, follow_speed * delta)
	else:
		# Get new offset by moving it back to follow at min distance
		# Clamp to make sure offset is not less than zero
		var new_offset = clampf(offset - (min_follow_distance - current_dist), 0, offset)
		path.get_child(0).progress = lerp(progress, new_offset, follow_speed * delta)
	
	pass
