extends KinematicBody2D

const MAX_SPEED_Y = 400
const GRAVITY = 330 # 330
var speed_y = 0
var motion = Vector2.ZERO

func _ready():
	pass # Replace with function body.

func _physics_process(delta):	
	# MOVEMENT
	if not is_on_floor():
		speed_y += GRAVITY * delta
		speed_y = clamp(speed_y, -MAX_SPEED_Y, MAX_SPEED_Y)
		motion.y = speed_y
# warning-ignore:return_value_discarded
		move_and_slide(motion, Vector2(0, -1))

