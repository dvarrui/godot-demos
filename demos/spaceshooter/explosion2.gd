extends Node2D

func _ready():
	$particles.one_shot = true
	$particles.emitting = true
	$timer.start($particles.lifetime+0.5)

func _on_timer_timeout():
	queue_free()
