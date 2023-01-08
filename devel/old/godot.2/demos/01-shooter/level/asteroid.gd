
extends Area2D

export var max_speed = Vector2(100, 50)
export var max_rot_speed = 0.05
export var max_wait_time = 0.0

var speed = Vector2(0,0)
var screen = Vector2(0,0)
var pos = Vector2(0,0)
var wait_time = 1.0
var total_time = 0.0
var state = "waiting"
var level = null
var rot_speed = 0

func _ready():
	screen = get_viewport_rect()
	level = get_tree().get_root().get_node("level")
	init()
	set_process(true)

func init(): #Initialize the enemy attributes
	state = "running"
	total_time = 0.0
	wait_time = rand_range( 0.0, max_wait_time )
	
	speed.x = rand_range( -max_speed.x, max_speed.x )
	speed.y = rand_range( -max_speed.y, max_speed.y )
	rot_speed = rand_range( -max_rot_speed, max_rot_speed)
	
	pos = Vector2(0,0)
	pos.y = rand_range(10, screen.size.y-10 )
	pos.x = screen.size.x
	if (speed.x > 0.0):
		pos.x = 0
		
	set_pos(pos)

func _process(delta):
	#must wait a time before go into screen again
	if (state=="waiting"):
		hide()
		total_time = total_time + delta
		if (total_time > wait_time):
			state="running"
			show()
		return
	
	if (state == "running"): 	#Translate/move
		translate(Vector2( speed.x * delta , speed.y * delta))
		rotate( rot_speed)

func _on_asteriod_area_enter( area ):
	if (area.get_name()=="player"): #Collides with our player
		area.exploit()
	
	# Collides with an shot object
	if (area extends preload("res://player/shot.gd")):
		area.queue_free() #The shot disappear

func _on_VisibilityNotifier2D_exit_screen():
	init() #When exit screen then initialize it
