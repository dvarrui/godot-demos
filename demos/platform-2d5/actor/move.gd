extends Node

var fsm: StateMachine
var limit = { "n":0, "s":0, "e":0, "w":0 }

func enter():
	pass

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	_update_limits()
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
	
	motion = dir.normalized() * fsm.speed_walk * delta
	if motion.x > limit["e"]:
		motion.x = limit["e"]
	elif motion.x < limit["w"]:
		motion.x = limit["w"]
		
	if motion.y > limit["s"]:
		motion.y = limit["s"]
	elif motion.y < limit["n"]:
		motion.y = limit["n"]

	if motion.x != 0 or motion.y != 0:
		print(motion)
		print(limit)
#		print(clamp(motion.x, limit["e"], limit["w"]))
#		print(clamp(motion.y, limit["s"], limit["n"]))
		
	fsm.translate(motion)
	return delta

func _update_limits():
	_update_north_limit()
	_update_south_limit()
	_update_west_limit()
	_update_east_limit()

func _update_north_limit():
	var p1 = fsm.get_cell_coord()
	var p2 = fsm.get_cell_coord() + Vector2(0, -1)
	limit["n"] = 0 - (int(fsm.position.y-10) % 48)
	if fsm.get_cell_id(p1) == fsm.get_cell_id(p2):
		limit["n"] += -48

func _update_south_limit():
	var p1 = fsm.get_cell_coord()
	var p2 = fsm.get_cell_coord() + Vector2(0, 1)
	limit["s"] = 47 - (int(fsm.position.y+10) % 48)
	if fsm.get_cell_id(p1) == fsm.get_cell_id(p2):
		limit["s"] += 48

func _update_west_limit():
	var p1 = fsm.get_cell_coord()
	var p2 = fsm.get_cell_coord() + Vector2(-1, 0)
	limit["w"] = 0 - (int(fsm.position.x-10) % 48)
	if fsm.get_cell_id(p1) == fsm.get_cell_id(p2):
		limit["w"] += -48

func _update_east_limit():
	var p1 = fsm.get_cell_coord()
	var p2 = fsm.get_cell_coord() + Vector2(1, 0)
	limit["e"] = 47 - (int(fsm.position.x+10) % 48)
	if fsm.get_cell_id(p1) == fsm.get_cell_id(p2):
		limit["e"] += 48

func physics_process(delta):
	return delta

func input(event):
	return event

func unhandled_input(event):
	return event

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]
