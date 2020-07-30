extends Node2D

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	
	var x = $player.position.x 
	var y = $player.position.y
	$info/position.text = "("+str(int(x))+","+str(int(y))+")"
	$info/tile.text = str($player.get_cell_id($player.get_cell_coord()))

