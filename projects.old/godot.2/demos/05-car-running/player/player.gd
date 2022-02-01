
extends Node2D

func _ready():
	set_process(true)
	
func _process(delta):
	translate(Vector2(10,0))

