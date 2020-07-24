extends Node2D

var state = "play"

func _ready():
	print_debug(Global.load_filename("level1.txt"))
	pass

func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

func end_game():
	state = "endgame"
	$game_over.visible = true
	$timer.start(3)

func _on_timer_timeout():
	get_tree().quit()
