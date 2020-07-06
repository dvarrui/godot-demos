extends KinematicBody2D

export var speed = 100
export var default_gravity = 170
export var jump_speed = -200
var state = "walking"
var current_gravity = 0
var previous_pos = Vector2.ZERO

func _ready():
	previous_pos = position
	current_gravity = default_gravity

# warning-ignore:unused_argument
func _physics_process(delta):
	if abs(previous_pos.y - position.y) < 0.1:
		if state=="falling":
			state = "walking"
		elif state=="jumping":
			state="falling"
			current_gravity = default_gravity
	var motion = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		motion.x = -speed
	if Input.is_action_pressed("player_right"):
		motion.x = speed
	if Input.is_action_just_pressed("player_jump") and state == "walking":
		current_gravity = jump_speed
		state = "jumping"
		$jump_timer.start()
	motion.y = current_gravity
	previous_pos = position
# warning-ignore:return_value_discarded
	move_and_slide(motion)


func _on_jump_timer_timeout():
	current_gravity = default_gravity
	state = "falling"
