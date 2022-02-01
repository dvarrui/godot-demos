
extends Node2D

var time_interval = 3

func _ready():
	set_process(true)
	get_node("sound").play("explosion")
	get_node("effect").set_emitting(true)

func _process(delta):
	time_interval -= delta
	if time_interval<=0:
		get_tree().change_scene("res://menu/menu.tscn")
	