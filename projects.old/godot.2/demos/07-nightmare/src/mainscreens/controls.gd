
extends Node2D

func _ready():
	get_node("music").play("default")

func _on_btn_back_pressed():
	get_tree().change_scene("res://src/mainscreens/menu.tscn")
