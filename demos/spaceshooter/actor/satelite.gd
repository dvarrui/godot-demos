extends Area2D

export var speed_y = 10
export var life = 4
var bullet_res = null
var explosion_res = null
var player = null

func _ready():
	bullet_res = preload("res://actor/bullet_down.tscn")
	explosion_res = preload("res://world/explosion.tscn")
	$timer.stop()
	player = get_tree().root.get_node("level/player")

func _process(delta):
	update_movement(delta)
	if abs(position.y-player.position.y)< 5:
		if position.x < player.position.x:
			shot("right")
		else:
			shot("left")

func update_movement(delta):
	position.y += (speed_y + Global.camera_speed) * delta

func _on_satelite_area_entered(area):
	if area.is_in_group("bullet_up"):
		area.hit()
		hit()
	if area.is_in_group("player"):
		area.hit()
		self.explode()

func hit():
	life -= 1
	if life > 0:
		$sprite.self_modulate = Color(0.5, 0.5, 0.5, 1)
		$timer.start(0.15)
		shot("down")
	else:
		explode()

func _on_timer_timeout():
	$sprite.self_modulate = Color(1, 1, 1, 1)
	$timer.stop()

func shot(direction):
	print("[INFO] satelite shot "+direction)
	var bullet = bullet_res.instance()
	bullet.position = self.position + Vector2(0, +40)
	get_parent().add_child(bullet)

func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()
