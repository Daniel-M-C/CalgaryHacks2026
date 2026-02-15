extends Node3D

@export var speed := 5

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO

	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("right"):
		direction.x += speed * delta
	if Input.is_action_pressed("left"):
		direction.x -= speed * delta
	if Input.is_action_pressed("down"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += speed * delta
	if Input.is_action_pressed("up"):
		direction.z -= speed * delta
		
	self.position += direction
