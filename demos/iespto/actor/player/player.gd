extends KinematicBody2D

export var speed = 12000 # Pixels/second
var state = "idle"
var direction = "down"

func _ready():
	refresh_anim()
	$anim.playing = true 

func refresh_anim():
	$anim.animation = state + "_" + direction

func update_motion(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("move_up"):
		motion += Vector2(0, -1)
		direction = "up"
		state = "walk"
	if Input.is_action_pressed("move_down"):
		motion += Vector2(0, 1)
		direction = "down"
		state = "walk"
	if Input.is_action_pressed("move_left"):
		motion += Vector2(-1, 0)
		direction = "left"
		state = "walk"
	if Input.is_action_pressed("move_right"):
		motion += Vector2(1, 0)
		direction = "right"
		state = "walk"
	
	if Input.is_action_just_released("move_down"):
		state = "idle"
	if Input.is_action_just_released("move_up"):
		state = "idle"
	if Input.is_action_just_released("move_right"):
		state = "idle"
	if Input.is_action_just_released("move_left"):
		state = "idle"

	motion = motion.normalized() * speed * delta
	move_and_slide(motion)

func _physics_process(delta):
	z_index = position.y
	update_motion(delta)
	refresh_anim()