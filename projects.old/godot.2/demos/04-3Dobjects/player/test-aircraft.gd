
extends Node

var speed = 100
var player

func _ready():
	player = get_node("aircraft")
	set_process(true)
	
func _process(delta):
	var dir = Vector3(0,0,0)
	
	if Input.is_action_pressed("player_left"):
		dir.x = dir.x - speed * delta
	if Input.is_action_pressed("player_right"):
		dir.x = dir.x + speed * delta
	if Input.is_action_pressed("player_up"):
		dir.z = dir.z - speed * delta
	if Input.is_action_pressed("player_down"):
		dir.z = dir.z + speed * delta

	player.translate(dir)

