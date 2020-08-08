extends Node

# Node: states/move 
var host = null
var prev = {}
var post = {}
var dir = Vector2.ZERO

func enter(_host):
	host = _host
	host.get_node("anim").play("move")

func exit(next_state):
	host.change_to(next_state)

# Optional handler functions for game loop events
# warning-ignore:unused_argument
func update(delta):
	prev["coord"] = host.get_cell_coord()
	prev["tile"] = host.get_cell_id(prev["coord"])
	if prev["tile"] == -1:
		exit("fall") 

	var motion = Vector2.ZERO
	# Add handler code here
	dir = Vector2.ZERO
	if Input.is_action_pressed("player_up"):
		dir += Vector2(0,-1)
	if Input.is_action_pressed("player_down"):
		dir += Vector2(0,1)
	if Input.is_action_pressed("player_left"):
		dir += Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		dir += Vector2(1,0)
	if Input.is_action_pressed("player_jump"):
		exit("jump")
	
	motion = dir.normalized() * host.speed_walk
	prev["coord"] = host.get_cell_coord()
	prev["tile"] = host.get_cell_id(prev["coord"])
	host.move_and_slide(motion)
	post["coord"] = host.get_cell_coord()
	post["tile"] = host.get_cell_id(post["coord"])
	
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
		#host.set_height(host.height - 1)
		if prev["coord"].x < post["coord"].x: 
			host.position.x += 10
		else:
			host.position.x -= 10
		exit("fall")
	elif prev["tile"] == 1 and post["tile"]== -1 and prev["coord"].y < post["coord"].y:
		exit("fall")
	elif prev["tile"] == 1 and post["tile"]== -1 and prev["coord"].y > post["coord"].y:
		# Down stairs
		host.set_height(host.height - 1)
