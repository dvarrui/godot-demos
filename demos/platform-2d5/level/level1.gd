extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
	
	var x = $player.position.x 
	var y = $player.position.y
	$info/position.text = "("+str(int(x))+","+str(int(y))+")"
	$info/tile.text = str($map_height.get_cell(x/48,y/48))
