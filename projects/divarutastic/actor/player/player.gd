extends KinematicBody2D

# Input
var input_direction = Vector2.ZERO # Input XY direction
var direction = Vector2.ZERO       # Current XY direction
var speed = Vector2.ZERO # Character speed

const X_ACCELERATION = 600
const X_DECELERATION = 1300 # 2000
const MAX_FLOOR_SPEED_X = 120

const MAX_STAIRS_SPEED_X = 50
const MAX_STAIRS_SPEED_Y = 100

const MAX_AIR_SPEED_X = 100
const UP_FORCE = 210 # 210
const DOWN_FORCE = 280 # 210
const MAX_SPEED_UP = -400
const MAX_SPEED_DOWN = 300

var on_stairs = false

func _ready():
	set_physics_process(true)
	set_process_input(true)
	$anim.play("idle")
	$anim.playing = true

func _input(event):
	if event.is_action_pressed("player_jump") and is_on_floor():
		speed.y = -UP_FORCE

func _physics_process(delta):
	_get_input_direction()

	if is_on_floor():
		_update_speed_on_floor(delta)
	elif on_stairs:
		_update_speed_on_stairs(delta)
	elif is_on_ceiling():
		speed.x = clamp(speed.x, 0, MAX_AIR_SPEED_X)
		speed.y = DOWN_FORCE * delta
		speed.y = clamp(speed.y, MAX_SPEED_UP, MAX_SPEED_DOWN)
	else:
		_update_speed_on_air(delta)
		
	# Apply motion
	var motion = Vector2()
	motion.x = speed.x * direction.x
	motion.y = speed.y
# warning-ignore:return_value_discarded
	move_and_slide(motion, Vector2(0, -1))
	update_anim(motion)

func _get_input_direction():
	# INPUT horizontal direction
	if Input.is_action_pressed("player_left"):
		input_direction.x = -1
	elif Input.is_action_pressed("player_right"):
		input_direction.x = 1
	else:
		input_direction.x = 0

	# Vertical movement	
	input_direction.y = 0
	if on_stairs:
		if Input.is_action_pressed("player_up"):
			input_direction.y = -1
		if Input.is_action_pressed("player_down"):
			input_direction.y = 1

func _update_speed_on_floor(delta):
	if input_direction.x == - direction.x:
		speed.x /= 3
	elif input_direction.x:
		speed.x += X_ACCELERATION * delta
	else:
		speed.x -= X_DECELERATION * delta
	direction.x = input_direction.x
	
	speed.x = clamp(speed.x, 0, MAX_FLOOR_SPEED_X)
	speed.y += DOWN_FORCE * delta
	speed.y = clamp(speed.y, MAX_SPEED_UP, MAX_SPEED_DOWN)

func _update_speed_on_stairs(delta):
	if input_direction.x == - direction.x:
		speed.x /= 3
	elif input_direction.x:
		speed.x += X_ACCELERATION * delta
	else:
		speed.x -= X_DECELERATION * delta
	direction.x = input_direction.x
	direction.y = input_direction.y
	
	speed.x = clamp(speed.x, 0, MAX_STAIRS_SPEED_X)
	speed.y = MAX_STAIRS_SPEED_Y * direction.y
	speed.y = clamp(speed.y, -MAX_STAIRS_SPEED_Y, MAX_STAIRS_SPEED_Y)
	
func _update_speed_on_air(delta):
	if input_direction.x == - direction.x:
		speed.x /= 3
	elif input_direction.x:
		speed.x += X_ACCELERATION/3.0 * delta
	else:
		speed.x -= X_DECELERATION/3.0 * delta
	direction.x = input_direction.x
	
	speed.x = clamp(speed.x, 0, MAX_AIR_SPEED_X)
	speed.y += DOWN_FORCE * delta
	speed.y = clamp(speed.y, MAX_SPEED_UP, MAX_SPEED_DOWN)

func update_anim(motion):
	# ANIM
	if on_stairs:
		_update_anim_on_stairs(motion)
	elif is_on_floor():
		_update_anim_on_floor(motion)
	else:
		_update_anim_on_air(motion)

func _update_anim_on_floor(motion):
	if motion.x==0:
		$anim.play("idle")
	elif motion.x > 0:
		$anim.play("walk")
		$anim.flip_h = false
	elif motion.x < 0:
		$anim.play("walk")
		$anim.flip_h = true

func _update_anim_on_air(motion):
	if motion.y > 1:
		$anim.play("fall")
	elif motion.y < -1:
		$anim.play("jump")
	
func _update_anim_on_stairs(motion):
	if motion.y==0:
		$anim.play("stairs-idle")
	else:
		$anim.play("stairs")

func _on_visibility_screen_exited():
	get_tree().quit()

func _on_detect_area_entered(area):
	if area.is_in_group("stairs"):
		on_stairs = true

func _on_detect_area_exited(area):
	if area.is_in_group("stairs"):
		on_stairs = false
