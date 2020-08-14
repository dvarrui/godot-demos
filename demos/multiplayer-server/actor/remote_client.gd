extends Node2D

func init(p_name):
	name = p_name
	$sprite/label.text = name
	print("[SERVER] path=" + get_path() + ", name=" + name )
 
remote func update_client_position(new_position):
	position = new_position
