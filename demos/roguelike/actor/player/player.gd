extends KinematicBody2D

export var speed = 12000 # Pixels/second
export var initial_pos = Vector2(80,127) # Initial position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	z_index = position.y
	update_motion(delta)

func update_motion(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("player_up"):
		motion += Vector2(0, -1)
	if Input.is_action_pressed("player_down"):
				motion += Vector2(0, 1)
	if Input.is_action_pressed("player_left"):
		motion += Vector2(-1, 0)
	if Input.is_action_pressed("player_right"):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * speed * delta
	move_and_slide(motion)

func reset():
	position = initial_pos
