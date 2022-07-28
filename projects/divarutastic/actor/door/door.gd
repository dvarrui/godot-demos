extends Node2D

export var keys = 1

func _ready():
	$anim/keys.text = str(keys)
	
func open():
	if MyConfig.keys < keys:
		return false
	MyConfig.keys = MyConfig.keys - keys 
	keys = 0
	var level = self.get_parent().get_parent()
	level.update_keys(0)

	$anim.play("open")
	$anim.play("opened")
	$body/shape.set_disabled(true)
	$body/shape.disabled = true
	$body.collision_layer = 16
	#$body/shape.position(self.position.x * -1, self.position.y * -1) # FIXME

func _on_detect_body_entered(body):
	if body.is_in_group("player"):
			self.open()
