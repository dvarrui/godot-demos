extends Node2D

var IP = "127.0.0.1"
var PORT = 5000
var id = 0 
onready var client = $client

func _ready():
	var net = NetworkedMultiplayerENet.new()	
	if (net.create_client(IP, PORT) != OK):
		print("[CLIENT] Failed to create client")
		return
	get_tree().set_network_peer(net)
	get_tree().set_network_peer(net)
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_disconnected_from_server")
	id = get_tree().get_network_unique_id()
	client.init(id)

func _on_connected_to_server():
	print("[CLIENT] Connected to server")
	client.show_info()

func _on_connection_failed():
	print("[CLIENT] Connection failed")
	
func _on_disconnected_from_server():
	print("[CLIENT] Disconnected from server")
	get_tree().quit()
	
func _process(delta):
	if Input.is_action_pressed("game_quit"):
		rpc("despawn_rep_client", id)
		get_tree().quit()
		print("[CLIENT] Quit! (" + str(id)+ ")")
		
remote func spawn_rep_client(id, pos):
	var rep_client = load("res://actor/rep_client.tscn").instance()
	rep_client.init(id, pos)
	add_child(rep_client)

remote func despawn_rep_client(id):
	print("[CLIENT] Despawn id="+str(id))
	get_node(str(id)).queue_free()
