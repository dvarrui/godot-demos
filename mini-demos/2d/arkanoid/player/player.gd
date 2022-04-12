extends KinematicBody2D

export var speed = 7

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		motion = Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		motion = Vector2(1,0)
	move_and_collide(motion*speed)
	pass
