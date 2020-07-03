extends Node2D

func _on_start_pressed():
	start_new_game()

func _on_quit_pressed():
	close_game()

func _process(delta):
	if Input.is_action_just_pressed("game_new"):
		start_new_game()
	if Input.is_action_just_pressed("game_quit"):
		close_game()

func start_new_game():
	get_tree().change_scene("res://level/level1.tscn")

func close_game():
	get_tree().quit()
