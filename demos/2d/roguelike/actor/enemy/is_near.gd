extends Area2D

var parent = null 

func _ready():
	parent = self.get_parent()

func _on_is_near_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == 'player':
		parent.player_is_near()

func _on_is_near_body_shape_exited(body_id, body, body_shape, area_shape):
	if body.name == 'player':
		parent.player_is_far()
