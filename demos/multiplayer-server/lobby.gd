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
	print("[SERVER] path=" + get_path() + "(id=" + str(id) + ")")
	
func _client_connected(id):
	print('[SERVER] Client connected (id=' + str(id) + ')')

	var new_client = load("res://actor/remote_client.tscn").instance()
	new_client.init(str(id))     # spawn players with their respective names
	add_child(new_client)

func _client_disconnected(id):
	print("[SERVER] Client disconnected (id=" + str(id) + ")")
	get_node(str(id)).free()
