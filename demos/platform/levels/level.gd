extends Node2D

var player_origin = Vector2.ZERO

func _ready():
	player_origin = $player.position

func _process(delta):
	if Input.is_action_just_pressed("game_quit"):
		get_tree().quit()
