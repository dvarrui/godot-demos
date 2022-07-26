extends Node2D

export var keys = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func update():
	if keys == 0:
		open() 
		
func open():
	$anim.play("open")
	$anim.play("opened")
	get_node("body/shape").set_disabled(true)
