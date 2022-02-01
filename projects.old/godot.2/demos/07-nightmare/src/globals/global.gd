
extends Node

var enemies_killed = 0
var laser_counter = 0

func _ready():
	init()

func init():
	enemies_killed = 0
	laser_counter = 0
	
func create_3ties(parent):
	var scene = preload("res://src/actors/enemies/enemy.tscn")
	var pos = Vector2(randf()*get_viewport().get_rect().size.x-70,70) 
	var enemy1 = scene.instance()
	var enemy2 = scene.instance()
	var enemy3 = scene.instance()
	var node = parent.get_node("enemies")
	enemy1.set_pos(pos); node.add_child(enemy1)
	enemy2.set_pos(Vector2(pos.x-70,pos.y-70)); node.add_child(enemy2)
	enemy3.set_pos(Vector2(pos.x+70,pos.y-90)); node.add_child(enemy3)

func create_3asteroids(parent):
	var scene = preload("res://src/actors/asteroid/asteroid1.tscn")
	var pos = Vector2(randf()*get_viewport().get_rect().size.x,0) 
	var asteroid1 = scene.instance()
	var asteroid2 = scene.instance()
	var node = parent.get_node("enemies")
	asteroid1.set_pos(pos); node.add_child(asteroid1)
	asteroid2.set_pos(Vector2(pos.x-10,pos.y-70)); node.add_child(asteroid2)

func get_points():
	var points = enemies_killed*10 - laser_counter
	if points <0:
		points = str("0")
	return str(points)