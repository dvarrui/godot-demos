extends Area2D

export var speed_y = +300
export var speed_x = 0

func _ready():
	pass # Replace with function body.

func set_direction(direction):
	if direction == "down":
		rotate(0.0)
		speed_y = Global.camera_speed + 300
		speed_x = 0
	elif direction == "left":
		speed_y = Global.camera_speed
		speed_x = -300
		rotate(1.57)
	elif direction == "right":
		speed_y = Global.camera_speed
		speed_x = 300
		rotate(1.57)


func _process(delta):
	position.y += delta * speed_y
	position.x += delta * speed_x

func _on_visibility_screen_exited():
	queue_free()

func hit():
	queue_free()
