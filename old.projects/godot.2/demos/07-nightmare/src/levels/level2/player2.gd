
extends Area2D

var speed = 200
var laser_interval = 0
var laser_timeout = 0.3
var close_interval = 0
var close_timeout = 3
var state = "playing"

func _ready():
	set_process(true)

func _process(delta):
	var vel = Vector2(0,0)
	if state=="playing":
		if Input.is_action_pressed("player_left"):
			vel += Vector2(-speed*delta,0)
		if Input.is_action_pressed("player_right"):
			vel += Vector2(speed*delta,0)
		if Input.is_action_pressed("player_up"):
			vel += Vector2(0,-speed*delta)
		if Input.is_action_pressed("player_down"):
			vel += Vector2(0,speed*delta)
		if Input.is_action_pressed("player_fire"):
			shot()
	
		translate(vel)
		get_node("engine").update_engine(vel,delta)
		laser_interval += delta
	if state=="exploding":
		close_interval -= delta
		if close_interval<=0:
			queue_free()

func shot():
	if laser_interval < laser_timeout:
		return
	laser_interval = 0
	var scene = preload("res://player/shot.tscn") 
	var node = scene.instance()
	var pos = get_pos()
	pos.y -= 32
	node.set_pos(pos)
	var parent = get_tree().get_root().get_node("level2/bullets")
	parent.add_child(node)
	get_node("sound").play("shot")

func explode():
	get_node("sprite").hide()
	var node = get_node("explosion").set_emitting(true)
	var pos = get_pos()
	node.set_pos(pos)
	close_interval = close_timeout
	state = "exploding"

func reload():
	#TODO
	var pos = get_viewport_rect().size
	pos.x = pos.x/2
	pos.y = pos.y-100
	move(pos)