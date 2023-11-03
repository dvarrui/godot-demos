extends Node2D

@export var tremor_offset = 5
@export var duration = 3.0
var object = null
var initial_pos = Vector2.ZERO
var state = "alive"

func _ready():
	object = self
	initial_pos = object.position
	$timer.wait_time = duration
	
func _process(delta):
	tremor()

func tremor():
	if state != "alive":
		return
	var x = randf_range(-tremor_offset, tremor_offset)
	var y = randf_range(-tremor_offset, tremor_offset)
	var tremor_pos = Vector2(x, y)
	object.position = initial_pos + tremor_pos
	
func _on_timer_timeout():
	state = "end"

