extends Node2D

var max_life = 1
var acc_life = 0

func _ready():
	max_life = max($fire.lifetime, $fire/pieces.lifetime) + 0.5
	$fire.visible = true
	$fire.one_shot = true
	$fire.emitting = true
	$fire/pieces.visible = true
	$fire/pieces.one_shot = true
	$fire/pieces.emitting = true
	$fire/smoke.visible = true
	$fire/smoke.one_shot = true 
	$fire/smoke.emitting = true
	$fire/smoke2.visible = true
	$fire/smoke2.one_shot = true 
	$fire/smoke2.emitting = true

func _process(delta):
	acc_life += delta
	if acc_life > max_life:
		queue_free()
