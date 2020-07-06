extends KinematicBody2D

export var speed = 100
export var gravity = 170

func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _physics_process(delta):
	var motion = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		motion.x = -speed
	if Input.is_action_pressed("player_right"):
		motion.x = speed
	motion.y = gravity
# warning-ignore:return_value_discarded
	move_and_slide(motion)
