extends Node

var host = null

func enter(_host):
	host = _host

func update(delta):
	yield(get_tree().create_timer(2.0), "timeout")
	exit()

func exit():
	get_tree().quit()
