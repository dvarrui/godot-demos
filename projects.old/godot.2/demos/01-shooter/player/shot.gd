
extends Area2D

const SPEED = 400

func _ready():
	set_process(true)
	get_node("sample").play("shot")

func _process(delta):
	translate(Vector2(0, -SPEED * delta))
	
func _on_VisibilityNotifier2D_exit_screen():
	queue_free()
