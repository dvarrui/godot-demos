extends Node2D

func _process(_delta):
	# Player wins!
	if get_node("wall").get_child_count() == 0:
		get_tree().quit()
	# Quit game!
	if Input.is_action_pressed("game_quit"):
		get_tree().quit()
	# Pause game
	if Input.is_action_pressed("game_pause"):
		$pause.visible = true
		get_tree().set_pause(true)
