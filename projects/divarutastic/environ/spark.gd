extends Node2D

export var lifetime = 10

func _ready():
	pass # Replace with function body.

func _process(delta):
	lifetime -= delta * 10
	if lifetime < 0:
		queue_free()
