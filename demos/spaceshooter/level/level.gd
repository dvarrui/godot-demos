extends Node2D

var state = "play"
var data = null
var data_index = 0

func _ready():
	data = Global.load_filename("level1.txt")
	$timers/build.start(1)

func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

func finish_game():
	state = "endgame"
	$game_over.visible = true
	$timers/endgame.start(3)

func _on_endgame_timeout():
	get_tree().quit()

func _on_build_timeout():
	if data_index < data.size():
		var items = data[data_index]
		if items[0] == "#":
			print("   [BUILD] " + items[1])
		else:
			print("=> " + items[0] + " with " + items[1])
			var node = Global.build_node_with(items[0], items[1])
			get_node("obstacles").add_child(node)
		data_index += 1
		print(Global.build_timeout)
		$timers/build.start(Global.build_timeout)

