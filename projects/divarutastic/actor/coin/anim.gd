extends AnimatedSprite

export var lifetime = 10

func _ready():
	pass # Replace with function body.

func _process(delta):
	lifetime -= delta
	if lifetime < 0:
		queue_free()
