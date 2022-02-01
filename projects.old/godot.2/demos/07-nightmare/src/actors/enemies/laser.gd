
extends RigidBody2D

var SPEED = 500
var alive = true

func _ready():
	apply_impulse(Vector2(0,0),Vector2(0,SPEED))	
	set_fixed_process(true)

func _fixed_process(delta):
	for item in get_colliding_bodies():
		alive = false
		if (item.get_name()=="player"):
			item.explode() 
	
	if alive == false:
		queue_free()

func explode():
	queue_free()