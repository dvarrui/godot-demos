extends Node2D

signal game_finished()

func _process(delta):
	if Input.action_press("game_exit"):
		emit_signal("game_finish")
