extends Node2D

signal game_finished

onready var player1 = $player1
onready var player2 = $player2

func _ready():
	# By default, all nodes in server inherit from master,
	# while all nodes in clients inherit from puppet.
	# set_network_master is tree-recursive by default.
	if get_tree().is_network_server():
		# For the server, give control of player 2 to the other peer.
		player2.set_network_master(get_tree().get_network_connected_peers()[0])
	else:
		# For the client, give control of player 2 to itself.
		player2.set_network_master(get_tree().get_network_unique_id())

func _process(delta):
	if Input.is_action_just_pressed("game_menu"):
		emit_signal("game_finished")
