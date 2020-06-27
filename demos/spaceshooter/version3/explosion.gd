extends Node2D

var max_life = 1
var acc_life = 0

func _ready():
	max_life = $fire.lifetime + 0.5
	$fire.visible = true
	$fire.one_shot = true
	$fire.emitting = true

func _process(delta):
	acc_life += delta
	if acc_life > max_life:
		queue_free()
