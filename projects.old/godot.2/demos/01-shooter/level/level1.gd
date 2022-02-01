
extends Node2D

export var max_asteroids = 1
export var max_enemies = 1
export var new_level_time = 30.0

var pts = 0
var total_time = 0.0

func _ready():
	set_process(true)
	show_pts()
	for i in range(max_enemies):
    	build_enemy()
	for i in range(max_asteroids):
    	build_asteroid()
	
func _process(delta):
	total_time = total_time + delta
	if (total_time > new_level_time):
		total_time = 0
		build_enemy()
		build_asteroid()

func build_enemy():
	var enemy_res = preload("res://enemy/enemy.xml")
	var enemy_scene = enemy_res.instance()
	get_node("enemies").add_child( enemy_scene )

func build_asteroid():
	var asteroid_res = preload("res://level/asteroid.xml")
	var asteroid_scene = asteroid_res.instance()
	get_node("asteroids").add_child( asteroid_scene )
	
func show_pts():
	get_node("text/points").set_text( str(pts) )
	
func inc_pts():
	pts = pts + 10
	show_pts()
