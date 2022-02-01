
extends RigidBody2D

var timeout = 2
var SPEED = 500
var alive = true

func _ready():
	apply_impulse(Vector2(0,0),Vector2(0,-SPEED))	
	set_fixed_process(true)

func _fixed_process(delta):
	for body in get_colliding_bodies():
		if body.is_in_group("enemy"):
			global.enemies_killed += 1
			body.explode()
			alive = false
		if body.is_in_group("asteroid"):
			alive = false
	
	if alive == false:
		queue_free()

func explode():
	queue_free()