
extends Node

var enemies_killed = 0

func _ready():
	pass

func create_3ties(parent):
	var scene = preload("res://level2/enemy2.tscn")
	var pos = Vector2(randf()*get_viewport().get_rect().size.x-70,70) 
	var enemy1 = scene.instance()
	var enemy2 = scene.instance()
	var enemy3 = scene.instance()
	var node = parent.get_node("enemies")
	enemy1.set_pos(pos); node.add_child(enemy1)
	enemy2.set_pos(Vector2(pos.x-70,pos.y-70)); node.add_child(enemy2)
	enemy3.set_pos(Vector2(pos.x+70,pos.y-90)); node.add_child(enemy3)
