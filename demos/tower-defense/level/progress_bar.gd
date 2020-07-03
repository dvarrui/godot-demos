extends Node2D

var max_time = 5
var acc_time = 0
var value = 0

func _ready():
	$value.text = str(value)

func _process(delta):
	acc_time += delta
	if acc_time > max_time:
		acc_time = 0
		value +=1
		$value.text = str(value)
