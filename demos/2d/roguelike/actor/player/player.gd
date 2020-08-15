extends KinematicBody2D

export var speed = 12000 # Pixels/second
var origin = Vector2(10,10) # Initial position
var keys = 0

func _ready():
	origin = position

func _physics_process(delta):
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
	if Input.is_action_pressed("goto_next_level"):
		self.take_key()
	
	motion = motion.normalized() * speed * delta
	move_and_slide(motion)

func reset():
	position = origin
	keys = 0
	get_parent().reset()

func take_key():
	keys += 1
	get_parent().open_doors_with(keys)
