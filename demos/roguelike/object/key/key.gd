extends Area2D

var origin = Vector2(0,0)

func _ready():
	origin = position

func reset():
	position = origin
	visible = true

func _on_key_body_entered(body):
	if body.name == 'player':
		visible = false
		position = Vector2(0,0)
		body.take_key()
