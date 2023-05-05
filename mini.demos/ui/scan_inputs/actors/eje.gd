extends Node2D

export var axis = 0
onready var label = $label

func _ready():
	label.text = "a"+ str(axis)
	
func _unhandled_input(event):
	if event is InputEventJoypadMotion and event.axis == axis:
		var msg = "axis=" + str(event.axis) + " value=" + str(event.axis_value)
		print(msg)
	
