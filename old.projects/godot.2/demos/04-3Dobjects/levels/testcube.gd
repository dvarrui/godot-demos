
extends Node

var camera = null
var speed = 7

func _ready():
	camera = get_node("camera")
	set_process(true)
	
func _process(delta):
	var dir = Vector3(0,0,0)
		
	if Input.is_action_pressed("camera_left"):
		dir.x = dir.x - speed * delta
	if Input.is_action_pressed("camera_right"):
		dir.x = dir.x + speed * delta
	if Input.is_action_pressed("camera_up"):
		dir.y = dir.y + speed * delta
	if Input.is_action_pressed("camera_down"):
		dir.y = dir.y - speed * delta

	camera.translate(dir)


