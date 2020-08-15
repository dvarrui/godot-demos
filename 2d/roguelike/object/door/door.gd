extends StaticBody2D

export var required_keys = 3
var origin = Vector2(0,0)

func _ready():
	origin = position

func open_with(keys):
	if keys == required_keys:
		get_node('sprite').visible = false
		collision_layer = 2
		position = Vector2(-100,-100)

func reset():
	get_node('sprite').visible = true
	collision_layer = 1 
	position = origin
