
extends Node2D

func _ready():
	get_node("music").play("default")
	get_node("tattoine").speed=0
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("game_exit"):
		game_exit()
	if Input.is_action_pressed("game_play"):
		game_play()
	
func game_play():
	get_node("music").stop_all()
	get_tree().change_scene("res://src/levels/level1.tscn")

func game_exit():
	get_tree().quit()

func _on_btn_play_pressed():
	game_play()

func _on_btn_controls_pressed():
	get_tree().change_scene("res://src/mainscreens/controls.tscn")

func _on_btn_exit_pressed():
	game_exit()
