extends Area2D

export var next_level = 'gameover'

func _ready():
	pass # Replace with function body.

func _on_exit_zone_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name != 'player':
		return
	if next_level == 'gameover':
		get_tree().quit()
	else:
		body.position = Vector2(0,0)
		get_tree().change_scene("res://level/" + next_level + ".tscn")
