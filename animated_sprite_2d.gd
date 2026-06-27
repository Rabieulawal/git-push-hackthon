extends CharacterBody2D

# How fast the player moves left/right
const SPEED = 300.0
# How high the player jumps (negative value because Y goes down in 2D)
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# 1. Apply Gravity if the player is in the air
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Handle Jumping using your custom 'move_up' action
	# Changed 'input' to 'Input' (Capital 'I')
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Get input direction using your custom left and right actions
	var direction := Input.get_axis("move_left", "move_right")
	
	# 4. Move the character based on input
	if direction:
		velocity.x = direction * SPEED
	else:
		# Smoothly slow down to a stop if no keys are pressed
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 5. Execute the movement and handle physics/collisions
	move_and_slide()
