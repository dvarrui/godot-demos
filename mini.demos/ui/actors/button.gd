extends Node2D

export var device_id = 0
export var button_id = 0
onready var label = $label
onready var rect = $rect

var disable_color = Color(0.2, 0.5, 0.2, 0.5)
var enable_color = Color(0, 1, 0, 1)

func _ready():
	label.text = str(button_id)

func _process(delta):
	if Input.is_joy_button_pressed(device_id, button_id):
		rect.color = enable_color
	else:
		rect.color = disable_color
