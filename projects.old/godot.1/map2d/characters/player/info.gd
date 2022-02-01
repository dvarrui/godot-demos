extends Node2D

var z = 0

func _process(delta):
	$z.text = "Z = " + str(z)
	
func set_info(a):
	z = a
	

