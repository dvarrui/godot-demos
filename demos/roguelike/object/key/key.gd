extends Area2D

var origin = Vector2(0,0)

func _ready():
	origin = position

func _on_key_area_entered(area):
	var node = area.get_parent()
	if node.name == 'player':
		visible = false
		position = Vector2(0,0)
		node.take_key()

func reset():
	position = origin
	visible = true
