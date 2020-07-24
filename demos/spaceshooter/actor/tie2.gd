extends Area2D

export var speed = 300
var max_shot_time = rand_range(1,6)
var acc_shot_time = 0
var bullet_res = null

func _ready():
	bullet_res = preload("res://actor/bullet_down.tscn")

func _process(delta):
	acc_shot_time += delta
	if acc_shot_time > max_shot_time:
		acc_shot_time -= max_shot_time
		max_shot_time = rand_range(1,6)
		shot()

func _on_tie_area_entered(area):
	if area.is_in_group("bullet_up"):
		area.queue_free()
		#$particles.show_on_top
		queue_free()

func shot():
	var bullet = bullet_res.instance()
	bullet.position = self.position + Vector2(0, +40)
	get_parent().add_child(bullet)

