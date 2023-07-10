
extends KinematicBody2D

var speed = 200
var laser_interval = 0
var laser_timeout = 0.3
var close_interval = 0
var close_timeout = 3.5
var state = "playing"

func _ready():
	add_to_group("player")
	set_fixed_process(true)

func _fixed_process(delta):
	var vel = Vector2(0,0)
	if state=="playing":
		var pos = get_pos()
		var screen = get_viewport_rect().size
		var margin = 30
		if Input.is_action_pressed("player_left") and pos.x>margin:
			vel += Vector2(-speed*delta,0)
		if Input.is_action_pressed("player_right") and pos.x<(screen.x-margin):
			vel += Vector2(speed*delta,0)
		if Input.is_action_pressed("player_up") and pos.y>margin:
			vel += Vector2(0,-speed*delta)
		if Input.is_action_pressed("player_down") and pos.y<(screen.y-margin):
			vel += Vector2(0,speed*delta)
		if Input.is_action_pressed("player_fire"):
			shot()
		move(vel)
		get_node("engine").update_engine(vel,delta)
		laser_interval += delta
	if state=="exploding":
		close_interval -= delta
		if close_interval <=0:
			get_tree().change_scene("res://src/mainscreens/menu.tscn")

func is_alive():
	if state=="playing":
		return true
	return false 

func is_dead():
	return !is_alive()
	
func shot():
	if laser_interval < laser_timeout:
		return
	laser_interval = 0
	global.laser_counter += 1
	var scene = preload("res://src/actors/player/shot.tscn") 
	var node = scene.instance()
	var pos = get_pos()
	pos.y -= 32
	node.set_pos(pos)
	var parent = get_tree().get_root().get_node("level/bullets")
	parent.add_child(node)
	get_node("sound").play("shot")

func explode():
	if state=="exploding":
		return
	state = "exploding"
	close_interval = close_timeout
	var scene = preload("res://src/actors/player/explosion.tscn") 
	var node = scene.instance()
	var pos = get_pos()
	node.set_pos(pos)
	get_parent().add_child(node)
	get_node("sprite").hide()
	get_node("engine").update_engine(Vector2(0,0),10)

func reload():
	#TODO
	var pos = get_viewport_rect().size
	pos.x = pos.x/2
	pos.y = pos.y-100
	move(pos)