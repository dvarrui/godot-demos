extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_1):
		$node1.set_process(false)
	if Input.is_key_pressed(KEY_3):
		$node1.set_process(true)
	if Input.is_key_pressed(KEY_2):
		$node2.set_process(false)
	if Input.is_key_pressed(KEY_4):
		$node2.set_process(true)
