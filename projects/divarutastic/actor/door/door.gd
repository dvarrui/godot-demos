extends Node2D

export var keys = 1

func open():
	MyConfig.keys - keys 
	keys = 0
	$anim.play("open")
	$anim.play("opened")
	print($body/shape.disabled)
	$body/shape.set_disabled(true)
	print($body/shape.disabled)

func _on_detect_body_entered(body):
	if body.is_in_group("player"):
		if MyConfig.keys >= keys:
			self.open()
