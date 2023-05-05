extends Node2D

export var keycode = 0
onready var label = $label
onready var rect = $rect

var disable_color = Color(0.5, 0.2, 0.2, 0.5)
var enable_color = Color(1, 0, 0, 1)

func _ready():
	rect.color = disable_color
	label.text = str(keycode)

func _process(delta):
	if Input.is_key_pressed(keycode):
		rect.color = enable_color
	else:
		rect.color = disable_color
