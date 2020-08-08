extends Node

# Node: states/jump
var host = null
var prev = {}
var GRAVITY = 450
var SPEED = Vector2(200,300)
var motion = Vector2.ZERO
var dir = Vector2.ZERO 
var going = ""

func enter(_host):
	host = _host
	host.get_node("anim").play("fall")
	prev["pos"] = host.position
	prev["coord"] = host.get_cell_coord()
	prev["tile"] = host.get_cell_id(prev["coord"])
	prev["height"] = host.height
	going = "up"
	motion = Vector2(0, -SPEED.y)
	host.set_height(host.height + 1)

func exit(next_state):
	host.change_to(next_state)

# Optional handler functions for game loop events
func update(delta):
	host.move_and_slide(motion)
	motion.x = SPEED.x/2.5 * dir.x
	motion.y += GRAVITY * delta
	
	var tile =  host.get_cell_id(host.get_cell_coord())
	if abs(motion.y) < 2 and going == "up":
		going = "down"
	elif going == "down":
		if dir.x == 0 and host.position.y > prev["pos"].y - 45 * 2:
			if tile in [1, 3]:
				exit("move")
		if dir.x != 0 and host.position.y > prev["pos"].y -45:
			if tile in [1, 3]:
				exit("move")
		if host.position.y > prev["pos"].y:
			if tile in [1, 3]:
				host.position.y = prev["pos"].y
				exit("move")
			else: 
				host.set_height(host.height - 1)
				exit("move")
