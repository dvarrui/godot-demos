extends Area2D

export var speed = -500
var explosion_res = null

func _ready():
	# explosion_res = preload("res://world/effect/explosion2.tscn")
	pass

func _process(delta):
	position.y += delta * speed

func _on_visibility_screen_exited():
	queue_free()
	
# func hit():
#	var explosion = explosion_res.instance()
#	explosion.position = self.position
	# get_parent().add_child(explosion)
	queue_free()
