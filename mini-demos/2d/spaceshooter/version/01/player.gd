extends Area2D

export var speed = 300

func _ready():
	pass # Replace with function body.

func _process(delta):
	var motion = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		motion += Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		motion += Vector2(1,0)
	if Input.is_action_pressed("player_up"):
		motion += Vector2(0,-1)
	if Input.is_action_pressed("player_down"):
		motion += Vector2(0,1)
	position += motion.normalized() * speed * delta

