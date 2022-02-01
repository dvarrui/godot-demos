
extends Node2D

var create_interval = 0
var create_timeout = 1.5

func _ready():
	create_interval = create_timeout
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("game_quit"):
		get_tree().change_scene("res://menu/menu.tscn")
	update_info()
	create_objects(delta)

func update_info():
	get_node("info/points").set_text("Points "+str(global2.enemies_killed))

func create_objects(delta):
	create_interval -= delta
	if create_interval <= 0:
		global2.create_3ties(self)
		create_interval = create_timeout