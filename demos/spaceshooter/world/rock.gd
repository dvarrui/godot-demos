extends Area2D

func _ready():
	randomize()
	if self.is_in_group("32"):
		$sprite/sprite2.position.x = rand_range(-50, 50)
		$sprite/sprite2.position.y = -40 + rand_range(-10, 10)
		$sprite/sprite3.position.x = rand_range(-30, 30)
		$sprite/sprite3.position.y = -80 + rand_range(-10, 10)
	elif self.is_in_group("64"):
		$sprite/sprite2.position.x = rand_range(-50, 50)
		$sprite/sprite2.position.y = -80 + rand_range(-20, 20)
		$sprite/sprite3.position.x = rand_range(-30, 30)
		$sprite/sprite3.position.y = -160 + rand_range(-10, 10)

func _process(delta):
	position.y += Global.camera_speed * delta 

func _on_rock32_area_entered(area):
	if area.is_in_group("player"):
		area.hit()
	if area.is_in_group("bullet_up"):
		area.hit()

func _on_visibility_screen_exited():
	queue_free()
