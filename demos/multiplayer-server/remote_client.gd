extends Node2D

func _ready():
	$sprite/label.text = name
	print("[SERVER] remote_client name = " +name+ " path = " + get_path())
 
remote func update_client_position(new_position):
	position = new_position
