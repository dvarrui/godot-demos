extends Node

var host = null

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
	host.move_and_slide(motion)
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
