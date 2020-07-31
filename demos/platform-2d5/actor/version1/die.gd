extends Node

var fsm: StateMachine

func enter():
	yield(get_tree().create_timer(2.0), "timeout")
	exit()

func exit():
	get_tree().quit()
