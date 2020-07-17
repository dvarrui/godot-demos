extends Node2D

var max_life = 1
var acc_life = 0

func _ready():
	max_life = max($fire.lifetime, $fire/pieces.lifetime) + 0.5
	var items = [ $fire, $fire/pieces, $fire/smoke, $fire/smoke2 ]
	for item in items:
		item.visible = true
		item.one_shot = true
		item.emitting = true

func _process(delta):
	acc_life += delta
	if acc_life > max_life:
		queue_free()
