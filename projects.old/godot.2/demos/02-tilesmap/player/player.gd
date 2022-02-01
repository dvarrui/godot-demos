
extends RigidBody2D

var speed = 100
var state = "down"

func _ready():
	set_mode(2)
	set_fixed_process(true)
	
func _fixed_process(delta):
	if Input.is_key_pressed(16777217) or Input.is_key_pressed(81):
		get_tree().quit()
	get_node("sprites/"+state).hide()
	var dir = Vector2(0,0)
	if Input.is_action_pressed("player_left"):
		dir.x = dir.x - speed * delta
		state="left"
	if Input.is_action_pressed("player_right"):
		dir.x = dir.x + speed * delta
		state="right"
	if Input.is_action_pressed("player_up"):
		dir.y = dir.y - speed * delta
		state="up"
	if Input.is_action_pressed("player_down"):
		dir.y = dir.y + speed * delta
		state="down"
	get_node("sprites/"+state).show()
	translate(dir)

