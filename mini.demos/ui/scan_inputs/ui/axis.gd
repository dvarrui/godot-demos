extends Node2D

onready var axis0lsl = $axis0lsl/rect
onready var axis0lsr = $axis0lsr/rect
onready var axis1lsu = $axis1lsu/rect
onready var axis1lsd = $axis1lsd/rect
onready var axis2rsl = $axis2rsl/rect
onready var axis2rsr = $axis2rsr/rect
onready var axis3rsu = $axis3rsu/rect
onready var axis3rsd = $axis3rsd/rect

var disable_color = Color(0.2, 0.2, 0.5, 0.5)
var enable_color = Color(0, 0, 1, 1)

func _ready():
	axis0lsl.color = disable_color
	axis0lsr.color = disable_color
	axis1lsu.color = disable_color
	axis1lsd.color = disable_color
	axis2rsl.color = disable_color
	axis2rsr.color = disable_color
	axis3rsu.color = disable_color
	axis3rsd.color = disable_color
	
# func _unhandled_input(event):
#	if event is InputEventJoypadMotion and event.axis == id:
#		var msg = "axis=" + str(event.axis) + " value=" + str(event.axis_value)
#		print(msg)
	
func _process(delta):
	if Input.is_action_pressed("axis_0_LSL"):
		axis0lsl.color = enable_color
	else:
		axis0lsl.color = disable_color

	if Input.is_action_pressed("axis_0_LSR"):
		axis0lsr.color = enable_color
	else:
		axis0lsr.color = disable_color

	if Input.is_action_pressed("axis_1_LSU"):
		axis1lsu.color = enable_color
	else:
		axis1lsu.color = disable_color

	if Input.is_action_pressed("axis_1_LSD"):
		axis1lsd.color = enable_color
	else:
		axis1lsd.color = disable_color

	if Input.is_action_pressed("axis_2_RSL"):
		axis2rsl.color = enable_color
	else:
		axis2rsl.color = disable_color

	if Input.is_action_pressed("axis_2_RSR"):
		axis2rsr.color = enable_color
	else:
		axis2rsr.color = disable_color

	if Input.is_action_pressed("axis_3_RSU"):
		axis3rsu.color = enable_color
	else:
		axis3rsu.color = disable_color

	if Input.is_action_pressed("axis_3_RSD"):
		axis3rsd.color = enable_color
	else:
		axis3rsd.color = disable_color
