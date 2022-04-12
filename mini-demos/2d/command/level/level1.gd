extends Node2D

export var speed = 10

func _ready():
	pass # Replace with function body.

func _process(delta):
	# Update camera
	$camera.position.y -= speed * delta
	# Exit game?
	if Input.is_action_pressed("exit_game"):
		exit_game()

func exit_game():
	get_tree().quit()
	
