extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var SPEED = 0
var gravity = 300
const top_speed = 600
const acceleration = 3
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	#Add animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "Run"
	else:
		animated_sprite_2d.animation = "Idle"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "Jump"

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		SPEED = move_toward(SPEED, top_speed, acceleration)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		SPEED = 0
		
	#modify gravity based on speed
	gravity = 300 + SPEED
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY, gravity)

	move_and_slide()
	
	#change sprite direction
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
