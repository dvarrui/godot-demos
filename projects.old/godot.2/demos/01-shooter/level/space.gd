
extends Node2D

export var speed = 10
var pos = Vector2(0,0)

func _ready():
	set_process(true)
	
func _process(delta):
	pos = get_pos()
	pos.y = pos.y + speed * delta
	if pos.y > 600:
		pos.y = 0
	
	set_pos(pos)

