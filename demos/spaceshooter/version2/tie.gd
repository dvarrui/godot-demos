extends Area2D

export var speed = 300
var max_shot_time = rand_range(1,6)
var acc_shot_time = 0
var bullet_res = null
var explosion_res = null

func _ready():
	bullet_res = preload("res://version3/bullet_down.tscn")
	explosion_res = preload("res://version3/explosion.tscn")

func _process(delta):
	acc_shot_time += delta
	if acc_shot_time > max_shot_time:
		acc_shot_time -= max_shot_time
		max_shot_time = rand_range(1,6)
		shot()

func _on_tie_area_entered(area):
	if area.is_in_group("bullet_up"):
		area.queue_free()
		var explosion = explosion_res.instance()
		explosion.position = self.position
		get_parent().add_child(explosion)
		queue_free()

func shot():
	var bullet = bullet_res.instance()
	bullet.position = self.position + Vector2(0, +40)
	get_parent().add_child(bullet)
