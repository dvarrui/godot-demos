extends Node2D

var IP = "127.0.0.1"
var PORT = 5000
const SPEED = 300
var id = 0 

func _ready():
	var net = NetworkedMultiplayerENet.new()
	
	if (net.create_client(IP, PORT) != OK):
		print("[CLIENT] Failed to create client")
		return
	get_tree().set_network_peer(net)
	id = get_tree().get_network_unique_id()
	name = str(id)
	$sprite/label.text = str(id)
	get_tree().set_network_peer(net)
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_disconnected_from_server")
	print("[CLIENT] id = " + str(id) + " path = "+ get_path())

func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		dir += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		dir += Vector2(1, 0)
	if Input.is_action_pressed("ui_up"):
		dir += Vector2(0, -1)
	if Input.is_action_pressed("ui_down"):
		dir += Vector2(0, 1)
		
	var motion = dir * SPEED * delta
	translate(motion)
	rpc_id(1, "update_client_position", position)

func _on_connected_to_server():
	print("[CLIENT] Connected to server")

func _on_connection_failed():
	print("[CLIENT] Connection failed")
	
func _on_disconnected_from_server():
	print("[CLIENT] Disconnected from server")

