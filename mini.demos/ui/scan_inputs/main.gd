extends Node2D

var Key = preload("res://ui/key.tscn")
var Button = preload("res://ui/button.tscn")
var Axis = preload("res://ui/axis.tscn")

func _ready():
	add_keys(32, 32)
	add_buttons(576, 32)
	add_axis(672,32)

func add_keys(x, y):
	var key
	var code = 0
		
	for row in range(16):
		for col in range(16):
			key = Key.instance()
			key.global_position = Vector2(x + col * 32, y + row * 32)
			key.keycode = code
			code += 1
			add_child(key)

func add_buttons(x, y):
	var device_id = 0
	var button_id = 0
		
	for col in range(2):
		for row in range(16):
			var button = Button.instance()
			button.global_position = Vector2(x + col * 32, y + row * 32)
			button.device_id = device_id
			button.button_id = button_id
			button_id += 1
			add_child(button)

func add_axis(x, y):
	var axis = Axis.instance()
	axis.global_position = Vector2(x, y)
	add_child(axis)
