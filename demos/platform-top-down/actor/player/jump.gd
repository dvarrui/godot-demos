extends Node

# Node: states/jump
var host = null
var prev = {}
var post = {}
var GRAVITY = 450
var SPEED = Vector2(200,300)
var motion = Vector2.ZERO

func enter(_host):
	host = _host
	host.get_node("anim").play("fall")
	prev["pos"] = host.position
	prev["coord"] = host.get_cell_coord()
	prev["tile"] = host.get_cell_id(prev["coord"])
	motion = Vector2(0, -SPEED.y)
	host.set_height(host.height + 1)

func exit(next_state):
	host.change_to(next_state)

# Optional handler functions for game loop events
func update(delta):
	host.move_and_slide(motion)
	motion.y += GRAVITY * delta
	
	if host.position.y > prev["pos"].y:
		host.position.y = prev["pos"].y
		host.set_height(host.height - 1)
		exit("move")
