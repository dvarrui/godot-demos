extends Node2D

func _process(delta):
	if Input.is_action_pressed("game_start"):
		get_tree().change_scene("res://level/level1.tscn")
