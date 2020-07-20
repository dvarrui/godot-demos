extends KinematicBody2D

# Input
var input_direction = Vector2.ZERO # Input XY direction
var direction = Vector2.ZERO       # Current XY direction
var speed = Vector2.ZERO # Character speed

const MAX_SPEED = Vector2(150,400) # 200, 400
const ACCELERATION = 600
const DECELERATION = 1300 # 2000
const JUMP_FORCE = 210 # 210
const GRAVITY = 330 # 330

var on_stairs = false

func _ready():
	#set_process(true)
	set_physics_process(true)
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("player_jump") and is_on_floor():
		speed.y = -JUMP_FORCE

func _physics_process(delta):
	# INPUT horizontal direction
	if is_on_floor() or on_stairs:
		if input_direction.x:
			direction.x = input_direction.x
		if Input.is_action_pressed("player_left"):
			input_direction.x = -1
		elif Input.is_action_pressed("player_right"):
			input_direction.x = 1
		else:
			input_direction.x = 0
	if on_stairs:
		direction.y = 0
		if Input.is_action_pressed("player_up"):
			direction.y = -1
		if Input.is_action_pressed("player_down"):
			direction.y = 1
		
	# MOVEMENT restrictions
	if is_on_floor() or on_stairs:
		# Horizontal movement
		if input_direction.x == - direction.x:
			speed.x /= 3
		elif input_direction.x:
			speed.x += ACCELERATION * delta
		else:
			speed.x -= DECELERATION * delta
		speed.x = clamp(speed.x, 0, MAX_SPEED.x)
	elif is_on_wall():
		# Limit X speed when collide with wall and is jumping
		speed.x = clamp(speed.x, 0, MAX_SPEED.x/5)
	elif is_on_ceiling():
		# Limit Y speed when collide with ceiling collide
		speed.y = 0
	else:
		# Limit max X speed when jumping
		speed.x = clamp(speed.x, 0, MAX_SPEED.x/3 +15)

	if on_stairs:
		speed.y = MAX_SPEED.y/3 * direction.y
	else:
		speed.y += GRAVITY * delta
		speed.y = clamp(speed.y, -MAX_SPEED.y, MAX_SPEED.y)

	var motion = Vector2()
	motion.x = speed.x * direction.x
	motion.y = speed.y
# warning-ignore:return_value_discarded
	move_and_slide(motion, Vector2(0, -1))
#	move_and_slide_with_snap(motion, Vector2.DOWN, Vector2.UP)
	# ANIM
	if is_on_floor():
		if motion.x==0:
			$anim.play("idle")
		elif motion.x > 0:
			$anim.play("walk")
			$anim.flip_h = false
		elif motion.x < 0:
			$anim.play("walk")
			$anim.flip_h = true
	else:
		if motion.y > 1:
			$anim.play("fall")
		elif motion.y < -1:
			$anim.play("jump")

func _on_visibility_screen_exited():
	get_tree().quit()

func _on_detect_area_entered(area):
	if area.is_in_group("stairs"):
		on_stairs = true
		z_index = -1

func _on_detect_area_exited(area):
	if area.is_in_group("stairs"):
		on_stairs = false
		z_index = 0
