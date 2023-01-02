extends Node2D

var parent = null 
export var speed = Vector2(250, 150)

func _ready():
	self.z_index = position.y

func enter(_parent):
	parent = _parent

func exit():
	pass

func process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("player_left"):
		dir.x = -1 
	if Input.is_action_pressed("player_right"):
		dir.x = 1 
	if Input.is_action_pressed("player_up"):
		dir.y = -1
	if Input.is_action_pressed("player_down"):
		dir.y = 1
	
	var velocity = dir.normalized() 
	velocity.x *= speed.x
	velocity.y *= speed.y
	parent.move_and_slide(velocity)
