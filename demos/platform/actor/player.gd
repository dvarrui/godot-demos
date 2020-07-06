extends KinematicBody2D

var input_direction = 0
var direction = 0

var speed_x = 0 # Horizontal speed about character
var speed_y = 0 # Vertical spped about character
var velocity = Vector2()

const MAX_SPEED = 300
const ACCELERATION = 1000
const DECELERATION = 2000

const JUMP_FORCE = 210
const GRAVITY = 300

func _ready():
	set_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("player_jump") and is_on_floor():
		speed_y = -JUMP_FORCE

func _process(delta):
	# INPUT
	if input_direction:
		direction = input_direction
	
	if Input.is_action_pressed("player_left"):
		input_direction = -1
	elif Input.is_action_pressed("player_right"):
		input_direction = 1
	else:
		input_direction = 0
	
	# MOVEMENT
	if input_direction == - direction:
		speed_x /= 3
	if input_direction:
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta

	speed_x = clamp(speed_x, 0, MAX_SPEED)
	speed_y += GRAVITY * delta

	velocity.x = speed_x * direction
	velocity.y = speed_y
# warning-ignore:return_value_discarded
	move_and_slide(velocity, Vector2(0, -1))

