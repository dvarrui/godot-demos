extends Node2D

enum { RUN, WAIT }
var progress = 0.0
var state = RUN

func _ready():
	pass
	# var tw = get_tree().create_tween()
	# tw.tween_property(sprite.material, "shader_param/shine_progress", 1, 2)
	# tween.interpolate_value(sprite.material, "shader_param/shine_progress", 1.0, 0.0, SHINE_TIME, Tween.TRANS_SINE, Tween.EASE_IN)
	# tween.interpolate_property(sprite.material, "shader_param/shine_size", 0.13, 0.01, SHINE_TIME * 0.75, Tween.TRANS_CUBIC, Tween.EASE_IN, SHINE_TIME * .25)
	
	# tween.interpolate_property(sprite.material, "shader_param/shine_progress", 0.0, 1.0, SHINE_TIME, Tween.TRANS_SINE, Tween.EASE_OUT, SHINE_TIME)
	# tween.interpolate_property(sprite.material, "shader_param/shine_size", null, 0.13, SHINE_TIME * 0.75, Tween.TRANS_CUBIC, Tween.EASE_OUT, SHINE_TIME * .25 + SHINE_TIME)
	# tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# shine(delta)

func shine(delta):
	var m : ShaderMaterial = $sprite.material
	progress += delta * 3
	print(progress)
	if progress > 6.0:
		# await get_tree().create_timer(3.0).timeout
		progress = 0.0
	m.set_shader_parameter("progress", progress)
