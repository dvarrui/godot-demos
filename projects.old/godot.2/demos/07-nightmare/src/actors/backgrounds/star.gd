
extends Node2D

var type = 1
var speed = 10

func _ready():
	set_process(true)
	randomize()
	type = randi()%6+1
	configure_type(type)

func configure_type(type):
	configure_speed(type)
	configure_sprite(type)
	
func configure_speed(type):
	speed = 10 * type
	
func configure_sprite(type):
	var i = 1
	while (i<6):
		if i == type:
			get_node("sprites/sprite"+str(i)).show()
		else:
			get_node("sprites/sprite"+str(i)).hide()
		i += 1

func _process(delta):
	translate( Vector2(0,speed * delta) )
	var pos = get_pos()
	var screen = get_viewport().get_rect().size
	if pos.y > screen.y:
		pos.y = 0
		pos.x = randf()*screen.x
		set_pos(pos)