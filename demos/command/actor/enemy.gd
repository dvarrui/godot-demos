extends KinematicBody2D

var state = "idle"
var rot_speed = 5
var bullet_res = load("res://actor/bullet.tscn") 
var max_wait_time = 1
var acc_wait_time = 0

func _physics_process(delta):
	if state=="idle":
		return
	if state=="shot":
		var dir = Vector2(cos(rotation), sin(rotation))
		shot(dir)
		acc_wait_time = 0
		state="wait"
	if state=="wait":
		acc_wait_time += delta
		if acc_wait_time >= max_wait_time:
			acc_wait_time = 0
			state = "shot"

func hurt():
	queue_free()

func _on_env_body_entered(body):
	if body.name=="player":
		state="shot"

func _on_env_body_exited(body):
	if body.name=="player":
		state="idle"

func shot(dir):
	var bullet = bullet_res.instance()
	bullet.position = self.position + dir * 40
	bullet.direction = dir
	get_parent().add_child(bullet)
