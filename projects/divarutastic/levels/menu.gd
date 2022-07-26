extends Node2D

func _ready():
	MyConfig.keys = 0
	
func _process(delta):
	if Input.is_action_just_pressed("game_new"):
		start_new_game()
	if Input.is_action_just_pressed("game_exit"):
		close_game()

func start_new_game():
	get_tree().change_scene("res://levels/level01.tscn")

func close_game():
	get_tree().quit()
