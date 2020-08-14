extends Node2D

var id = 0 

func init(p_id, p_pos):
	id = p_id
	name = str(id)
	position = p_pos
	$sprite/label.text = str(id)

func _ready():
	print("[CLIENT] Spawn id="+str(id)+" path="+get_path())

remote func update_rep_client(p_pos):
	position = p_pos
