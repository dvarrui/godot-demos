extends Area2D

export var speed_x = 60
export var speed_y = 60
export var max_x = 700
export var min_x = 64
export var life = 2
export var dir = 1
var max_shot_time = rand_range(1,6)
var acc_shot_time = 0
var bullet_res = null
var explosion_res = null

func _ready():
	bullet_res = preload("res://actor/enemy/bullet_down.tscn")
	explosion_res = preload("res://actor/effect/explosion.tscn")

func _process(delta):
	# Wait until enter on screen
	if position.y < 0:
		position.y += Global.camera_speed * delta
		return
	prob_shot(delta)
	update_movement(delta)

func update_movement(delta):
	position.x += speed_x * dir * delta
	position.y += (speed_y + Global.camera_speed) * delta
	if position.x > max_x and dir > 0:
		dir = -1
	if position.x < min_x and dir < 0:
		dir = 1
#	if dir > 0 and rotation < 0.3:
#		rotate(delta * 0.5)
#	if dir < 0 and rotation > -0.3:
#		rotate(delta * -0.5)

func _on_tie_area_entered(area):
	if area.is_in_group("bullet_up"):
		area.hit()
		hit()
	if area.is_in_group("player"):
		area.hit()
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
	bullet.set_direction("down")
	get_parent().add_child(bullet)

func hit():
	life -= 1
	if life > 0:
		$sprite/white_flash.activate()
	else:
		explode()

func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()

func _on_visibility_screen_exited():
	queue_free()
