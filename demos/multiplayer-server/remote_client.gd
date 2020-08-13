extends Node2D

func _ready():
	$sprite/label.text = name
	pass # Replace with function body.

remote func _update_client_position(new_position):
	position = new_position
