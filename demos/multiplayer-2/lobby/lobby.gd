extends Control

const DEFAULT_PORT = 8910 # An arbitrary number.

onready var address = $panel/address
onready var server_button = $panel/server_button
onready var join_button = $panel/join_button
onready var status_ok = $panel/status_ok
onready var status_fail = $panel/status_fail

func _ready():
	# Connect all the callbacks related to networking.
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func _process(delta):
	if Input.is_action_just_pressed("game_exit"):
		get_tree().quit()

#### Network callbacks from SceneTree ####

# Callback from SceneTree.
func _player_connected(_id):
	# Someone connected, start the game!
	var level = load("res://level/level1.tscn").instance()
	# Connect deferred so we can safely erase it from the callback.
	level.connect("game_finished", self, "_end_game", [], CONNECT_DEFERRED)
	get_tree().get_root().add_child(level)
	hide()

func _player_disconnected(_id):
	if get_tree().is_network_server():
		_end_game("Client disconnected")
	else:
		_end_game("Server disconnected")

# Callback from SceneTree, only for clients (not server).
func _connected_ok():
	pass # We don't need this function.

# Callback from SceneTree, only for clients (not server).
func _connected_fail():
	_set_status("Couldn't connect", false)
	get_tree().set_network_peer(null) # Remove peer.	
	server_button.set_disabled(false)
	join_button.set_disabled(false)

func _server_disconnected():
	_end_game("Server disconnected")

##### Game creation functions ######

func _end_game(with_error = ""):
	if has_node("/root/level1"):
		# Erase immediately, otherwise network might show errors (this is why we connected deferred above).
		get_node("/root/level1").free()
		show()
	
	get_tree().set_network_peer(null) # Remove peer.
	server_button.set_disabled(false)
	join_button.set_disabled(false)
	_set_status(with_error, false)


func _set_status(text, isok):
	# Simple way to show status.
	if isok:
		status_ok.set_text(text)
		status_fail.set_text("")
	else:
		status_ok.set_text("")
		status_fail.set_text(text)

func _on_server_button_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	var err = host.create_server(DEFAULT_PORT, 1) # Maximum of 1 peer, since it's a 2-player game.
	if err != OK:
		# Is another server running?
		_set_status("Can't host, address in use.",false)
		return
	
	get_tree().set_network_peer(host)
	server_button.set_disabled(true)
	join_button.set_disabled(true)
	_set_status("Waiting for player...", true)

func _on_join_button_pressed():
	var ip = address.get_text()
	if not ip.is_valid_ip_address():
		_set_status("IP address is invalid", false)
		return
	
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
	_set_status("Connecting...", true)

