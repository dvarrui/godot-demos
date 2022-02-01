
extends Node2D

var create_interval = 0
var create_timeout = 1.5
onready var player = get_node("player")
var music_volume = 0.2
var voice_id = 0

func _ready():
	create_interval = create_timeout
	voice_id = get_node("sample").play("rock")
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("game_quit"):
		get_tree().change_scene("res://src/mainscreens/menu.tscn")
	update_info()
	create_objects(delta)

func update_info():
	get_node("info/score").set_text("Score "+global.get_points())

func create_objects(delta):
	create_interval -= delta
	if create_interval <= 0:
		global.create_3ties(self)
		global.create_3asteroids(self)
		create_interval = create_timeout
	