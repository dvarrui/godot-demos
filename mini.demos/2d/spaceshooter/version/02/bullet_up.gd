extends Area2D

export var speed = -500

func _ready():
	pass # Replace with function body.

func _process(delta):
	position.y += delta * speed

func _on_visibility_screen_exited():
	queue_free()

