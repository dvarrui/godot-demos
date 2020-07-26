extends Area2D

export var speed_y = 60
var speed = Vector2.ZERO
var bullet_res = null
var explosion_res = null

func _ready():
	bullet_res = preload("res://actor/bullet_down.tscn")
	explosion_res = preload("res://environment/explosion.tscn")
	$timer.stop()

func _process(delta):
	update_movement(delta)

func update_movement(delta):
	position.y += (speed.y + Global.camera_speed) * delta

func _on_satelite_area_entered(area):
	if area.is_in_group("bullet_up"):
		area.hit()
		hit()
	if area.is_in_group("player"):
		area.hit()
		self.explode()

func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()

func hit():
	$sprite.self_modulate = Color(0.5, 0.5, 0.5, 1)
	$timer.start(0.15)

func _on_timer_timeout():
	$sprite.self_modulate = Color(1, 1, 1, 1)
	$timer.stop()
