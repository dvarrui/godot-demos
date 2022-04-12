
extends Node2D

var speed = 10
var planet

func _ready():
	planet = get_node("sprite")
	set_process(true)

func _process(delta):
	if speed==0:
		return
	planet.translate(Vector2(0,delta*speed))
	

