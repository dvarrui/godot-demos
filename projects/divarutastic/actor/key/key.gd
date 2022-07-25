extends Area2D

func _on_coin_body_entered(body):
	if not body.is_in_group("player"):
		return

	var level = self.get_parent().get_parent()
	level.update_keys(1)
	spawn_spark(self.position)
	
func spawn_spark(position):
	var data = { "type": "spark", 
			 "x": self.position.x,
			 "y": self.position.y }
	var level = self.get_parent().get_parent()
	Loader.create_new_object(data, level)
	queue_free()
