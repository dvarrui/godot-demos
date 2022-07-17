extends Node2D

export var lifetime = 1

func _ready():
	$timer.wait_time = lifetime

func _process(delta):
	lifetime -= delta * 10
	if lifetime < 0:
		queue_free()

func _on_timer_timeout():
		queue_free()
