extends Node

var fsm: StateMachine

func enter():
	pass

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	# Add handler code here
	var dir = Vector2.ZERO
	if Input.is_action_pressed("player_up") and can_move(Vector2(0,-1)):
		dir += Vector2(0,-1)
	if Input.is_action_pressed("player_down") and can_move(Vector2(0,1)):
		dir += Vector2(0,1)
	if Input.is_action_pressed("player_left"):
		dir += Vector2(-1,0)
	if Input.is_action_pressed("player_right"):
		dir += Vector2(1,0)
	
	fsm.translate(dir.normalized() * fsm.speed_walk * delta)
	return delta

func can_move(move):
	var a = fsm.get_cell_coord()
	var b = fsm.get_cell_coord() + move
	if fsm.get_cell_id(a) == fsm.get_cell_id(b):
		return true
	false


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
