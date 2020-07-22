extends Area2D

export var speed = 100
export var max_x = 700
export var min_x = 64
var dir = 1
var max_shot_time = rand_range(1,6)
var acc_shot_time = 0
var bullet_res = null
var explosion_res = null

func _ready():
	bullet_res = preload("res://actor/bullet_down.tscn")
	explosion_res = preload("res://environment/explosion.tscn")

func _process(delta):
	prob_shot(delta)
	update_movement(delta)

func update_movement(delta):
	position.x += speed * dir * delta
	if position.x > max_x and dir > 0:
		dir = -1
	if position.x < min_x and dir < 0:
		dir = 1
	if dir > 0 and rotation < 0.3:
		rotate(delta * 0.5)
	if dir < 0 and rotation > -0.3:
		rotate(delta * -0.5)

func _on_tie_area_entered(area):
	if area.is_in_group("bullet_up"):
		area.queue_free()
		explode()
	if area.is_in_group("player"):
		area.explode()
		self.explode()

func prob_shot(delta):
	acc_shot_time += delta
	if acc_shot_time > max_shot_time:
		acc_shot_time -= max_shot_time
		max_shot_time = rand_range(1,6)
		shot()
	
func shot():
	var bullet = bullet_res.instance()
	bullet.position = self.position + Vector2(0, +40)
	get_parent().add_child(bullet)

func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()
	
