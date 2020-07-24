extends Area2D

func _process(delta):
	position.y += Global.camera_speed * delta 

func _on_rock32_area_entered(area):
	if area.is_in_group("player"):
		area.hit()
	if area.is_in_group("bullet_up"):
		area.hit()

func _on_visibility_screen_exited():
	queue_free()
