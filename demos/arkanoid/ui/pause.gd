extends Node2D

func _on_continue_pressed():
	continue_game()

func _on_menu_pressed():
	goto_main_menu()

func _process(delta):
	if Input.is_action_just_pressed("game_continue"):
		continue_game()
	if Input.is_action_just_pressed("game_quit"):
		goto_main_menu()

func continue_game():
	get_tree().set_pause(false)
	hide()

func goto_main_menu():
	hide()
	get_tree().set_pause(false)
	get_tree().change_scene("res://ui/title.tscn")
