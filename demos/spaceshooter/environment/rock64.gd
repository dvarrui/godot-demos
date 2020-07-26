extends Area2D

func _ready():
	randomize()
	$sprite/sprite2.position.x = rand_range(-48, 48)
	$sprite/sprite2.position.y = -39 + rand_range(0, 10)
	$sprite/sprite3.position.x = rand_range(-28, 28)
	$sprite/sprite3.position.y = -72 + rand_range(0, 5)

func _process(delta):
	position.y += Global.camera_speed * delta 

func _on_rock32_area_entered(area):
	if area.is_in_group("player"):
		area.hit()
	if area.is_in_group("bullet_up"):
		area.hit()

func _on_visibility_screen_exited():
	queue_free()
