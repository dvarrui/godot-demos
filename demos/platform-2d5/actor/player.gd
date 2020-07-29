extends Node2D

export var speed_walk = 200
export var speed_fall = 400

func _ready():
	pass # Replace with function body.

func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("player_up"):
		dir += Vector2(0,-1)
	if Input.is_action_pressed("player_down"):
		dir += Vector2(0,1)
	if Input.is_action_pressed("player_left"):
		dir += Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		dir += Vector2(1,0)
	
	translate(dir.normalized()*speed_walk*delta)
