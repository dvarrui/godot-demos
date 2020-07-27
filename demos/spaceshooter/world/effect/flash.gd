extends Timer

var sprite = null

func _ready():
	sprite = get_parent()

func activate():
	sprite.self_modulate = Color(0.5, 0.5, 0.5, 1)
	start(0.15)

func _on_flash_timeout():
	sprite.self_modulate = Color(1, 1, 1, 1)
	stop()
