extends Node2D

var state = "play"

func _ready():
	Loader.build_file_into_level("data.txt", self)
	$timer/startgame.start(2)
	# $music.play(0)

func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

func finish_game():
	state = "endgame"
	$label.visible = true
	$label.text = "GAME OVER"
	$timer/endgame.start(3)

func _on_startgame_timeout():
	$label.visible = false
	$timer/startgame.stop()

func _on_endgame_timeout():
	get_tree().quit()
