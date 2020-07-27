extends Area2D

export var speed_y = +300
export var speed_x = 0

func _ready():
	pass # Replace with function body.

func _process(delta):
	position.y += delta * speed_y
	position.x += delta * speed_x

func _on_visibility_screen_exited():
	queue_free()

func hit():
	queue_free()
