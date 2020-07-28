extends Node2D

var state = "play"

func _ready():
	Loader.build_file_into_level("level2.txt", self)

func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

func finish_game():
	state = "endgame"
	$game_over.visible = true
	$timer/endgame.start(3)

func _on_endgame_timeout():
	get_tree().quit()
