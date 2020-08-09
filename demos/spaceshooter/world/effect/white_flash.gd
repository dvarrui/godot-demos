extends Timer

var sprite = null
var shader_res = null

func _ready():
	shader_res = preload("res://world/effect/white_flash.shader")
	print(shader_res)
	sprite = get_parent()
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = shader_res

func activate():
	sprite.material.set_shader_param("flash_modifier", 1.0)
	start(0.05)

func _on_white_flash_timeout():
	sprite.material.set_shader_param("flash_modifier", 0.0)
	stop()
