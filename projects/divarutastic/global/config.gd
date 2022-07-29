extends Node

var keys = 0
var position = Vector2(-1, -1)

func _ready():
	pass # Replace with function body.

func reset():
	self.keys = 0
	self.position = Vector2(-1, -1)

func screen_size():
	var size = Vector2(1024, 600)
	return size
