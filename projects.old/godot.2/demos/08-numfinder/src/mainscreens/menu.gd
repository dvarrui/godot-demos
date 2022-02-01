
extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("game_start"):
		game_start()
	if Input.is_action_pressed("game_credits"):
		game_credits()
	if Input.is_action_pressed("game_quit"):
		game_quit()
	
func _on_start_pressed():
	game_start()
	
func _on_credits_pressed():
	game_credits()

func _on_exit_pressed():
	game_quit()
	
func game_start():
	get_tree().change_scene("res://src/levels/level1.tscn")

func game_quit():
	get_tree().quit()
	
func game_credits():
	prints("TODO: game credits...")
