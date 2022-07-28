extends Node2D

export var keys = 1

func _ready():
	$anim/keys.text = str(keys)

func _on_detect_body_entered(body):
	if body.is_in_group("player") and keys > 0:
			update_keys()

func _physics_process(delta):
	if keys == 0:
		open() 

func update_keys():
	if MyConfig.keys < keys:
		return false
	MyConfig.keys = MyConfig.keys - keys 
	keys = 0
	var level = get_parent().get_parent()
	level.update_keys(0)

func open():
	$anim.play("open")
	$anim.play("opened")
	$body/shape.set_disabled(true)
