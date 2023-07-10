
extends KinematicBody2D

var MOVE_SPEED = 300
var ROT_SPEED = 5
var screen = Vector2(0,0)
var pos = Vector2(0,0)
var rot = 0
var engine = null
var state = "playing"
var state_interval = 0
var state_timeout = 0

func _ready():
	screen = get_viewport().get_rect().size
	pos = Vector2(screen.x/2, screen.y/2)
	set_pos(pos)
	set_rot(rot)
	engine = get_node("engine")
	engine.hide()
	set_process(true)

func _process(delta):
	if state=="playing":
		state_playing(delta)
	if state=="exploding":
		state_exploding(delta)

func state_playing(delta):
	if Input.is_action_pressed("game_quit"):
		get_tree().change_scene("res://levels/menu.tscn")
	if Input.is_action_pressed("turn_left"):
		rot += ROT_SPEED * delta
	if Input.is_action_pressed("turn_right"):
		rot -= ROT_SPEED * delta
	if Input.is_action_pressed("player_move"):
		pos += Vector2(0,-1).rotated(rot) * MOVE_SPEED * delta
		state_interval = 3
		if not get_node("engine").is_playing():
			get_node("engine").play("default")
	if pos.x<0 or pos.x>screen.x or pos.y<0 or pos.y>screen.y:
		state_explode()

	state_interval -= delta
	if state_interval <= 0:
		state_interval = 0
		get_node("engine").stop()

	set_pos(pos)
	set_rot(rot)

func state_explode():
	if state!="playing":
		pass
	state_interval = 2
	state = "exploding"
	get_node("sounds").play("explosion")
	get_node("sprite").hide()

func state_exploding(delta):
	state_interval -= delta
	if state_interval<=0:
		get_tree().change_scene("res://src/mainscreens/menu.tscn")
