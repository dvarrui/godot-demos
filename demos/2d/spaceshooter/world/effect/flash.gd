extends Timer

var sprite = null
export var duration = 0.15

func _ready():
	sprite = get_parent()

func activate():
	sprite.self_modulate = Color(0.5, 0.5, 0.5, 1)
	start(duration)

func _on_flash_timeout():
	sprite.self_modulate = Color(1, 1, 1, 1)
	stop()
