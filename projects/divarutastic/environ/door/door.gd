extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func open():
	$anim.play("open")
	$anim.play("opened")
	get_node("body/shape").set_disabled(true)
