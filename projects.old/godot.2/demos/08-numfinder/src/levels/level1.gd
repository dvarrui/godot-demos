
extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	var camera_pos = get_node("player/camera").get_camera_pos()
	camera_pos -= get_viewport_rect().size/2
	get_node("texts").set_pos(camera_pos)
