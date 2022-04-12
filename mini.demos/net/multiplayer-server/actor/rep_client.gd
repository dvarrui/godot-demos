extends Node2D

var id = 0
func init(p_id):
	id = p_id
	name = str(id)
	$sprite/label.text = name
 
func _ready():
	print("[SERVER] rep_client path=" + get_path() )
	
remote func update_rep_client(new_position):
	position = new_position

