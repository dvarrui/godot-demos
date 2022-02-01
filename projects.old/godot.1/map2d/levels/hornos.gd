extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	$floor_map.z_index = $player.z_index - 1000
	$wall_map.z_index = $player.z_index - 999
