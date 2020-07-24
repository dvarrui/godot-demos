extends Node2D

var state = "play"
var data = null

func _ready():
	data = Global.load_filename("level1.txt")
	$timers/build.start(1)

func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

func end_game():
	state = "endgame"
	$game_over.visible = true
	$timers/endgame.start(3)

func _on_endgame_timeout():
	get_tree().quit()

func _on_build_timeout():
	print("build...")
	$timers/build.start(1)
