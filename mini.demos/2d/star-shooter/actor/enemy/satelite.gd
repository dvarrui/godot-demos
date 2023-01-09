extends Area2D

export var speed_y = 10
export var life = 4
export var can_shot_timeout = 0.75
export var distance_y = 100
var bullet_res = null
var explosion_res = null
var player = null
var can_shot = true

func _ready():
	bullet_res = preload("res://actor/enemy/bullet_down.tscn")
	explosion_res = preload("res://actor/effect/explosion.tscn")
	player = get_tree().root.get_node("level/player")

func _process(delta):
	if position.y < 0:
		position.y += Global.camera_speed * delta
		return 
	update_movement(delta)
	if player==null:
		return
	if abs(self.position.y-player.position.y) < distance_y:
		if self.position.x < player.position.x:
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
		$sprite/white_flash.activate() 
		shot("down")
	else:
		explode()

func shot(direction):
	if not can_shot:
		return
	var bullet = bullet_res.instance()
	if direction in ["left","right"]:
		can_shot = false
		$timer/can_shot.start(can_shot_timeout)
		bullet.position = self.position + Vector2(0, 0)
	else:
		bullet.position = self.position + Vector2(0, +40)
	bullet.set_direction(direction)
	get_parent().add_child(bullet)

func _on_can_shot_timeout():
	can_shot = true

func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()

func _on_visibility_screen_exited():
	queue_free()
