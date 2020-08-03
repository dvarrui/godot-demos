extends Node

var host = null
var prev = {}
var post = {}

func enter(_host):
	host = _host

func exit(next_state):
	host.change_to(next_state)

# Optional handler functions for game loop events
func update(delta):
	var motion = Vector2.ZERO
	# Add handler code here
	var dir = Vector2.ZERO
	if Input.is_action_pressed("player_up"):
		dir += Vector2(0,-1)
	if Input.is_action_pressed("player_down"):
		dir += Vector2(0,1)
	if Input.is_action_pressed("player_left"):
		dir += Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		dir += Vector2(1,0)
	
	motion = dir.normalized() * host.speed_walk
	prev["tile"] = host.get_cell_id(host.get_cell_coord())
	prev["coord"] = host.get_cell_coord()
	host.move_and_slide(motion)
	post["tile"] = host.get_cell_id(host.get_cell_coord())
	post["coord"] = host.get_cell_coord()
	
	if post["tile"] == 0:
		exit("die")
	if prev["tile"] == 1 and post["tile"] == 3:
		# Up stairs
		host.set_height(host.height + 1)
	elif (prev["tile"] == 4 and post["tile"] == -1):
		# Down stairs
		host.set_height(host.height - 1)
	elif prev["tile"] == 1 and post["tile"] == -1 and post["coord"].y == prev["coord"].y:
		# Down stairs
		host.set_height(host.height - 1)
		#if host.get_cell_id(host.get_cell_coord()) == 2:
		#	host.move_and_slide(Vector2(0,48))
	elif prev["tile"] == 1 and post["tile"]== -1 and prev["coord"].y < post["coord"].y:
		print("[INFO] Caer por el muro...")
		print("prev=>"+str(prev))
		print("post=>"+str(post))
		
	return null

#func physics_process(delta):
#	return delta

func input(event):
	return event

func unhandled_input(event):
	return event

#func unhandled_key_input(event):
#	return event

#func notification(what, flag = false):
#	return [what, flag]
