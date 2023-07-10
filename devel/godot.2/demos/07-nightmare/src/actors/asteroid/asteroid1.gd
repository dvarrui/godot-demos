
extends RigidBody2D

var SPEED = 100
var screen = Vector2(0,0)

func _ready():
	add_to_group("asteroid")
	screen = get_viewport().get_rect().size
	set_fixed_process(true)
#	set_angular_velocity(3)
#	set_linear_velocity(Vector2(0,SPEED))
	apply_impulse(Vector2(0,0),Vector2(0,SPEED))

func _fixed_process(delta):
	if get_pos().y > screen.y:
		queue_free()
	for item in get_colliding_bodies():
		item.explode() 

func explode():
	pass
