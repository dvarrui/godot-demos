extends Area2D

func _on_coin_body_entered(body):
	if body.is_in_group("player"):
		var data = { "type": "spark", 
				 "x": self.position.x,
				 "y": self.position.y }
		var level = self.get_parent().get_parent()
		Loader.create_new_object(data, level)
		queue_free()
