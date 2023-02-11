extends Area2D

export var speed = -500
var explosion_res = null
onready var audio = $audio

func _ready():
	explosion_res = preload("res://actor/effect/explosion2.tscn")
	audio.play()
	
func _process(delta):
	position.y += delta * speed

func _on_visibility_screen_exited():
	queue_free()
	
func hit():
	var explosion = explosion_res.instance()
	explosion.position = self.position
	get_parent().add_child(explosion)
	queue_free()
