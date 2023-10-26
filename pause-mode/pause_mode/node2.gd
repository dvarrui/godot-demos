extends Node2D

var wait_time = 1
var time_acc = 0.0
var id = "Node 2"

func _process(delta):
	time_acc += delta
	if time_acc > wait_time:
		time_acc -= wait_time
		print(id)
