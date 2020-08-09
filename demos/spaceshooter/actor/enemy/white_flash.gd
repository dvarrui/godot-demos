extends Timer

var sprite = null

func _ready():
	sprite = get_parent()

func activate():
	sprite.material.set_shader_param("flash_modifier", 1.0)
	start(0.05)

func _on_white_flash_timeout():
	sprite.material.set_shader_param("flash_modifier", 0.0)
	stop()
