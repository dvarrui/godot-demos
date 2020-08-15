extends Node2D

var id = 0
func init(p_id):
	id = p_id
	name = str(id)
	$sprite/label.text = name
	print("[SERVER] rep_client name=" + name )
 
remote func update_rep_client(new_position):
	position = new_position
	
	#for i in get_parent().get_children():
	#	if i.name != name:
	#		rpc_id(i.name, "update_rep_client", position)
