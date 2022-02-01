
extends Node2D
export var SPEED = 300
var dir = 1
var last_drop_time = 0.0
var max_drop_time = 2.0

func _ready():
	set_process(true)
	
func _process(delta):
	# Move the hand
	var pos = get_pos()
	var screen = get_viewport().get_rect().size

	if pos.x>=(screen.x-64):
		dir = -1
	if pos.x<=(0+64):
		dir = 1
		
	var offset =  delta * SPEED * dir
	translate(Vector2(offset,0))

	# Drop the block
	last_drop_time -= delta
	
	var drop = Input.is_action_pressed("ui_accept")
	if (drop and last_drop_time<=0):
		var square_res = preload("res://blocks/square.xml")
		var square_scn = square_res.instance()
		pos.x = pos.x + 48
		pos.y = pos.y + 78
		square_scn.set_pos( pos )
		get_parent().add_child( square_scn )
		last_drop_time = max_drop_time 
