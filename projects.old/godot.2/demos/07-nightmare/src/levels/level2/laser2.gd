
extends Area2D

var SPEED = 500
var alive = true

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	translate(Vector2(0, -SPEED*delta ))
#	for item in get_colliding_bodies():
#		alive = false
#		if (item.get_name()=="player2"):
#			item.explode() 
	
	if alive == false:
		queue_free()
