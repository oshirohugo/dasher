extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const DASH_SPEED = 800
const DASH_DURATION = .2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var dash = $Dash

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta		
		animated_sprite.animation = "fall"
	else:
		if(velocity.x == 0):
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "walk"

	if Input.is_action_just_pressed("dash"):
		dash.start_dash(DASH_DURATION)

	var speed = DASH_SPEED if dash.is_dashing() else SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction = Input.get_axis("left", "right")
	var direction = get_direction(dash.is_dashing())

	if direction:
		velocity.x = direction * speed
		if(velocity.x < 0):
			animated_sprite.flip_h = true
		elif(velocity.x > 0):
			animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	animated_sprite.play()
	move_and_slide()

func get_direction(is_dashing: bool) -> float:
	var direction: float = Input.get_axis("left", "right")
	if direction:
		return direction
	if is_dashing:
		return 1 if animated_sprite.flip_h == false else -1
	return 0

