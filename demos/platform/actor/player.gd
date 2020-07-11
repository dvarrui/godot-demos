extends KinematicBody2D

var input_direction = 0 # Input X direction
var direction = 0       # Current X direction

var speed_x = 0 # Horizontal speed about character
var speed_y = 0 # Vertical spped about character
var motion = Vector2()

const MAX_SPEED_X = 200 # 200
const ACCELERATION = 600
const DECELERATION = 1300 # 2000

const MAX_SPEED_Y = 400
const JUMP_FORCE = 210 # 210
const GRAVITY = 330 # 330

func _ready():
	#set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("player_jump") and is_on_floor():
		speed_y = -JUMP_FORCE

func _physics_process(delta):
#func _process(delta):
	# INPUT
	if is_on_floor():
		if input_direction:
			direction = input_direction
		if Input.is_action_pressed("player_left"):
			input_direction = -1
		elif Input.is_action_pressed("player_right"):
			input_direction = 1
		else:
			input_direction = 0
	
	# MOVEMENT
	if is_on_floor():
		if input_direction == - direction:
			speed_x /= 3
		elif input_direction:
			speed_x += ACCELERATION * delta
		else:
			speed_x -= DECELERATION * delta
		speed_x = clamp(speed_x, 0, MAX_SPEED_X)
	elif is_on_wall():
		# Limit X speed when collide with wall and is jumping
		speed_x = clamp(speed_x, 0, MAX_SPEED_X/5)
	elif is_on_ceiling():
		# Limit Y speed when collide with ceiling collide
		speed_y = 0
	else:
		# Limit max X speed when jumping
		speed_x = clamp(speed_x, 0, MAX_SPEED_X/3 +15)
	
	speed_y += GRAVITY * delta
	speed_y = clamp(speed_y, -MAX_SPEED_Y, MAX_SPEED_Y)

	motion.x = speed_x * direction
	motion.y = speed_y
# warning-ignore:return_value_discarded
	move_and_slide(motion, Vector2(0, -1))
#	move_and_slide_with_snap(motion, Vector2.DOWN, Vector2.UP)

func _on_visibility_screen_exited():
	get_tree().quit()
