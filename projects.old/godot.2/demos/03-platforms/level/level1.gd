
extends Node2D

func _ready():
	set_process(true)
	
func _process(delta):
	if Input.is_key_pressed(16777217) or Input.is_key_pressed(81):
		get_tree().quit()