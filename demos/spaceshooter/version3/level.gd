extends Node2D

var state = "play"
var max_end_game = 1
var acc_end_game = 0

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
	if state == "endgame":
		acc_end_game += delta
		if acc_end_game > max_end_game:
			get_tree().quit()

func end_game():
	state = "endgame"
	$game_over.visible = true
