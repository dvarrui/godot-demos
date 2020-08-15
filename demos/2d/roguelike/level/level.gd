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
	for enemy in get_node('enemies').get_children():
		enemy.reset()

func open_doors_with(keys):
	# Try to open every door
	for door in get_node('doors').get_children():
		door.open_with(keys)

func _process(delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

