extends Area2D

export var speed = 300
var bullet_res = null
var screen = Vector2.ZERO 
var explosion_res = null

func _ready():
	bullet_res = preload("res://version/04/actor/player/laser/laser_up.tscn")
	# explosion_res = preload("res://world/effect/explosion.tscn")
	screen = get_viewport().size

func _process(delta):
	var motion = Vector2.ZERO
	if Input.is_action_just_pressed("player_shot"):
		shot()
	if Input.is_action_pressed("player_left") and position.x > 48:
		motion += Vector2(-1,0)
	if Input.is_action_pressed("player_right") and position.x < (screen.x-48):
		motion += Vector2(1,0)
	if Input.is_action_pressed("player_up") and position.y > 48:
		motion += Vector2(0,-1)
	if Input.is_action_pressed("player_down") and position.y < (screen.y-48):
		motion += Vector2(0,1)
	position += motion.normalized() * speed * delta

func shot():
	var bullet = bullet_res.instance()
	bullet.position = self.position + Vector2(0, -40)
	get_parent().add_child(bullet)

func _on_player_area_entered(area):
	if area.is_in_group("bullet_down"):
		area.queue_free()
		hit()

func hit():
	explode()
	
func explode():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	var level = get_tree().root.get_node("level")
	level.add_child(explosion)
	level.finish_game()
	self.hide()
	self.position=Vector2(-100,-100)
	#queue_free()
