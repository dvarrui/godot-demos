extends Area2D

func _ready():
	pass # Replace with function body.

func _on_key_area_entered(area):
	var node = area.get_parent()
	if node.name == 'player':
		visible = false
		node.take_key()
