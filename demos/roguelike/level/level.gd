extends Node2D

func _ready():
	pass # Replace with function body.

func reset():
	# Reset keys
	for key in get_node('keys').get_children():
		key.reset()
	# Reset doors
	for door in get_node('doors').get_children():
		door.reset()

func open_doors_with(keys):
	# Try to open every door
	for door in get_node('doors').get_children():
		door.open_with(keys)
