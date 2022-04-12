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

	var rep_client = load("res://actor/rep_client.tscn").instance()
	rep_client.init(id)     # spawn players with their respective names
	
	for i in self.get_children():
		rpc_id(int(i.name), "spawn_rep_client", id, Vector2.ZERO)
		rpc_id(id, "spawn_rep_client", int(i.name), i.position)
	add_child(rep_client)

func _client_disconnected(id):
	print("[SERVER] Client disconnected (id=" + str(id) + ")")
	get_node(str(id)).free()
