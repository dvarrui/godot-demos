extends Node2D

export var speed = 0.4
export var max_scale = 1.2
export var min_scale = 0.5
var dir = 1

func _process(delta):
	$sprite.scale += Vector2(speed*dir*delta, speed*dir*delta) 
	if $sprite.scale.x > max_scale:
		dir = -1
	if $sprite.scale.x < min_scale:
		dir = 1
