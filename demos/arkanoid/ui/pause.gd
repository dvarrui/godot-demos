extends Node2D

func _on_continue_pressed():
	get_tree().set_pause(false)
	hide()

func _on_menu_pressed():
	hide()
	get_tree().set_pause(false)
	get_tree().change_scene("res://ui/title.tscn")
