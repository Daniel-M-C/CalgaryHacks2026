extends Node3D

@onready var body = $CharacterBody3D


@onready var animated_sprite_3d: AnimatedSprite3D = $AnimatedSprite3D
const SPEED = 5.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta

	# Handle jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		body.velocity.x = direction.x * SPEED
		body.velocity.z = direction.z * SPEED
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, SPEED)
		body.velocity.z = move_toward(body.velocity.z, 0, SPEED)
	set_animation()
	body.move_and_slide()

func set_animation():

	if body.velocity.x > 0.1: animated_sprite_3d.flip_h = true
	elif body.velocity.x < -0.1: animated_sprite_3d.flip_h = false
	
	if body.velocity: animated_sprite_3d.play("left")
	else: animated_sprite_3d.play("idle")
