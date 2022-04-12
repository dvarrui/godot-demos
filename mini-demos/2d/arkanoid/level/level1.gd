extends Node2D

export var next_level = "game_over"

func _process(_delta):
	# Player wins!
	if get_node("wall").get_child_count() == 0:
		get_tree().change_scene("res://levels/" + next_level +".tscn")
	# Quit game!
	if Input.is_action_pressed("game_quit"):
		get_tree().change_scene("res://ui/title.tscn")
	# Pause game
	if Input.is_action_pressed("game_pause"):
		$pause.visible = true
		get_tree().set_pause(true)
