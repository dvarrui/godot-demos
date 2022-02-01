
extends Area2D

export var max_speed = Vector2(50,400)
export var min_speed = Vector2(0,10)
export var max_wait_time = 0.0

var speed = Vector2(0,0)
var size = Vector2(0,0)
var pos = Vector2(0,0)
var wait_time = 1.0
var total_time = 0.0
var state = "waiting"
var level = null

func _ready():
	size = get_viewport_rect().size
	level = get_tree().get_root().get_node("level")
	init()
	set_process(true)

func init(): #Initialize the enemy attributes
	state = "running"
	total_time = 0.0
	wait_time = rand_range( 0.0, max_wait_time )
	
	speed.x = rand_range( min_speed.x, max_speed.x )
	speed.y = rand_range( min_speed.y, max_speed.y )

	pos = Vector2(0,0)
	if (size.x > 0):
		pos.x = randi()%int(size.x)
	set_pos(pos)

func _process(delta):
	#The enemy must wait a time before go into screen again
	if (state=="waiting"):
		hide()
		total_time = total_time + delta
		if (total_time > wait_time):
			state="running"
			show()
		return
	
	#Translate/move the enemy
	if (state == "running"):
		translate(Vector2( speed.x * delta , speed.y * delta))

func _on_enemy_area_enter( area ):
	#The enemy collides with our player
	if (area.get_name()=="player"):
		area.exploit()
	
	# The enemy collides with an shot object
	if (area extends preload("res://player/shot.gd")):
		area.queue_free() #The shot disappear
		get_node("sample").play("exploit") #Play explosion sound
		level.inc_pts() #Increment player points
		init() #Initialize this enemy
		state="waiting"

func _on_VisibilityNotifier2D_exit_screen():
	init() #When the enemy exit screen then initialize it
