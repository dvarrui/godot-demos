extends Node2D

func _process(delta):
	$tilemap.z_index = $player.z_index - 1000
	$ball.z_index = $ball.position.y

