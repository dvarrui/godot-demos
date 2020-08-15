extends KinematicBody2D

var state = "idle"
var rot_speed = 5
var bullet_res = load("res://actor/bullet.tscn") 
var max_wait_time = 1
var acc_wait_time = 0
var player = null 

func _physics_process(delta):
	if state=="idle":
		return
	if state=="shot":
		# https://docs.godotengine.org/es/stable/tutorials/math/vector_math.html
		# Only shot when enemy can see player
		var Enemy2Player = self.position.direction_to(player.position)
		if Enemy2Player.dot(self.transform.x) > 0:
			shot(self.transform.x)
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
		player = body

func _on_env_body_exited(body):
	if body.name=="player":
		state="idle"

func shot(dir):
	var bullet = bullet_res.instance()
	bullet.position = self.position + dir * 40
	bullet.direction = dir
	# Set enemy bullet layer = enemy layer
	# To avoid enemies kill other enemies
	bullet.collision_layer = self.collision_layer 
	get_parent().add_child(bullet)
