extends Node

# states/fall
var host = null
var prev = {}
var post = {}
var speed = Vector2(0, 350)

func enter(_host):
	host = _host
	host.get_node("anim").play("fall")
	prev["pos"] = host.position
	prev["coord"] = host.get_cell_coord()
	prev["tile"] = host.get_cell_id(prev["coord"])
	post["pos"] = host.position + Vector2(0, 48+24)
	post["coord"] = host.get_cell_coord() + Vector2(0,2)
	post["tile"] = host.get_cell_id(post["coord"])

func exit(next_state):
	host.change_to(next_state)

# Optional handler functions for game loop events
func update(delta):
	var motion = Vector2(0,1) * speed.y * delta
	host.move_and_collide(motion)
	if host.position.y >= post["pos"].y:
		# Down stairs
		host.set_height(host.height - 1)
		exit("move")
