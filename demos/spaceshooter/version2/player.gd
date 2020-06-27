extends Area2D

export var speed = 300
var bullet_res = null
var explosion_res = null

func _ready():
	bullet_res = preload("res://version3/bullet_up.tscn")
	explosion_res = preload("res://version3/explosion.tscn")

func _process(delta):
	var motion = Vector2.ZERO
	if Input.is_action_just_pressed("player_shot"):
		shot()
	if Input.is_action_pressed("player_left"):
		motion += Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		motion += Vector2(1,0)
	if Input.is_action_pressed("player_up"):
		motion += Vector2(0,-1)
	if Input.is_action_pressed("player_down"):
		motion += Vector2(0,1)
	position += motion.normalized() * speed * delta

func shot():
	var bullet = bullet_res.instance()
	bullet.position = self.position + Vector2(0, -40)
	get_parent().add_child(bullet)

func _on_player_area_entered(area):
	if area.is_in_group("bullet_down"):
		area.queue_free()
		var explosion = explosion_res.instance()
		explosion.position = self.position
		get_parent().add_child(explosion)
		get_parent().end_game()
		queue_free()

