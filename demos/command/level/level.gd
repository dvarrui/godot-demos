extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	update_camera()
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()

func update_camera():
	if $camera.position.y > $player.position.y:
		$camera.position.y = $player.position.y
