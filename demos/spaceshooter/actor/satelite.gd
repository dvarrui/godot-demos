extends Area2D

export var speed_y = 10
export var life = 4
export var can_shot_timeout = 0.75
var bullet_res = null
var explosion_res = null
var player = null
var can_shot = true

func _ready():
	bullet_res = preload("res://actor/bullet_down.tscn")
	explosion_res = preload("res://world/explosion.tscn")
	$timer/flash.stop()
	player = get_tree().root.get_node("level/player")

func _process(delta):
	update_movement(delta)
	if player==null:
		return
	if abs(position.y-player.position.y) < 50:
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
		$timer/flash.start(0.15)
		shot("down")
	else:
		explode()

func _on_flash_timeout():
	$sprite.self_modulate = Color(1, 1, 1, 1)
	$timer/flash.stop()

func shot(direction):
	if not can_shot:
		return
	var bullet = bullet_res.instance()
	if direction in ["left","right"]:
		can_shot = false
		$timer/can_shot.start(can_shot_timeout)
		bullet.position = self.position + Vector2(0, 0)
		bullet.speed_y = Global.camera_speed
		bullet.speed_x = -300
		if direction == "right":
			bullet.speed_x = 300
		bullet.rotate(1.57)
	else:
		bullet.position = self.position + Vector2(0, +40)
	get_parent().add_child(bullet)

func _on_can_shot_timeout():
	can_shot = true

func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()
