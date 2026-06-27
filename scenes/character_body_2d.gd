extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const WALK_SPEED = 100.0
const SPRINT_SPEED = 175.0  # Adjustable sprinting speed
const JUMP_VELOCITY = -250.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Determine current movement speed based on sprinting input
	var current_speed = WALK_SPEED
	if Input.is_action_pressed("sprint"):
		current_speed = SPRINT_SPEED

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()
	
	# Call the animation function here
	update_animations(direction)


func update_animations(direction: float) -> void:
	# 1. Handle Flipping (horizontal mirroring)
	if direction > 0:
		animated_sprite.flip_h = false # Faces right
	elif direction < 0:
		animated_sprite.flip_h = true  # Flips the sprite to face left

	# 2. Handle Animation States based on movement and floor status
	if not is_on_floor():
		animated_sprite.play("player jump")
	else:
		if direction != 0:
			# If you want to use "player walk" instead when walking, 
			# you can check if Input.is_action_pressed("sprint") here!
			animated_sprite.play("player run")
		else:
			animated_sprite.play("player idle")
