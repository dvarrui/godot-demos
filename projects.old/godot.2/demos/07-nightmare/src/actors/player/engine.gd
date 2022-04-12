
extends Node2D

var vel = Vector2(0,0)
var engine_interval= 0
var engine_timeout = 1
var engine_frame = 0
var frame_interval= 0
var frame_timeout = 0.3

func _ready():
	pass

func update_engine(vel, delta):
	if vel.x!=0 or vel.y!=0:
		engine_interval = engine_timeout
		show()
		get_node("sprite").play()
		set_opacity(1)
	else:
		engine_interval -= delta*3
		if engine_interval < 1:
			set_opacity(engine_interval)
		if engine_interval < 0:
			engine_interval = 0
			get_node("sprite").stop()
 