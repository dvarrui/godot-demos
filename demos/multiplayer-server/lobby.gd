extends Node2D

const PORT        = 5000
const MAX_PLAYERS = 200
var id = 0

func _ready():
	var server = NetworkedMultiplayerENet.new()
	server.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(server)
	id = get_tree().get_network_unique_id()
	get_tree().connect("network_peer_connected",    self, "_client_connected"   )
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	print("[SERVER] Server (id="+ str(id) +") running " + get_path())
	
func _client_connected(id):
	print('[SERVER] Client ' + str(id) + ' connected to Server')

	var new_client = load("res://remote_client.tscn").instance()
	new_client.set_name(str(id))     # spawn players with their respective names
	add_child(new_client)

func _client_disconnected(id):
	get_node(id).free()
