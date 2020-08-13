
[<< back](multiplayer-n.md)

# 2. Menú principal

Vamos a diseñar una ventana principal ("main_menu") sencilla para poder elegir lo siguiente:
* Información del jugador: Nombre y color de su avatar.
* Información para crear el servidor: nombre, número máximo de clientes (Entre 2 y 16), puerto (por defecto 4546).
* Información para crear el cliente de red: IP del servidor y puerto (Por deefcto 4546).

## 2.1 Eventos de red

El sistema de red genera algunos eventos que debemos escuchar para actuar en consecuencia.

Eventos que genera el sistema de red de Godot:
* **connected_to_server()**: Se emite cuando un cliente se une al servidor.
* **connection_failed()**: Cuando falla el intento de un ciente de unirse a un servidor
* **network_peer_connected(id)**: Se envía a todos los conectados al servidor cuando se une un nuevo cliente. ID es el identificador del nuevo cliente.
* **network_peer_disconnected(id)**: Cuando el cliente ID se desconecta del servidor, se envía esta señal a todo el mundo.
* **server_disconnected()**: Evento recibio por un cliente cuando se desconecta del servidor.

> El fichero singleton "network.gd" lo usaremos para almacenar todas las funciones que tengan que ver con el manejo de la red.

```
# File: network.gd

# Conectar las señales (eventos) a funciones.

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_disconnected_from_server")

# Crear funciones con el código de respuesta a los eventos.

# Everyone gets notified whenever a new client joins the server
func _on_player_connected(id):
	pass

# Everyone gets notified whenever someone disconnects from the server
func _on_player_disconnected(id):
	pass

# Peer trying to connect to server is notified on success
func _on_connected_to_server():
	pass

# Peer trying to connect to server is notified on failure
func _on_connection_failed():
	pass

# Peer is notified when disconnected from server
func _on_disconnected_from_server():
	pass
```

## 2.2 Crear el servidor

Vamos a crear el código necesario en "network.gd" para crear el servidor de red.

```
# File: network.gd

var server_info = {
	name = "Server",      # Holds the name of the server
	max_players = 0,      # Maximum allowed connections
	used_port = 0         # Listening port
}

signal server_created   # when server is successfully created

func create_server():
	# Initialize the networking system
	var net = NetworkedMultiplayerENet.new()

	# Try to create the server
	if (net.create_server(server_info.used_port, server_info.max_players) != OK):
		print("Failed to create server")
		return

	# Assign it into the tree
	get_tree().set_network_peer(net)
	# Tell the server has been created successfully
	emit_signal("server_created")
```

La función anterior se invocará desde el "main_menu". Cuando se pulse el botón de crear servidor, se emitirá la señal "server_created", y cuando se reciba se cargará la escena principal del juego ("game_world.tscn").

```
# File: main_menu.gd

func _ready():
	network.connect("server_created", self, "_on_ready_to_play")

func _on_ready_to_play():
	get_tree().change_scene("res://game_world.tscn")

func _on_btCreate_pressed():
	# Gather values from the GUI and fill the network.server_info dictionary
	if (!$PanelHost/txtServerName.text.empty()):
		network.server_info.name = $PanelHost/txtServerName.text
	network.server_info.max_players = int($PanelHost/txtMaxPlayers.value)
	network.server_info.used_port = int($PanelHost/txtServerPort.text)

	# And create the server, using the function previously added into the code
	network.create_server()
```

## 2.3 Unirse a un servidor

Vamos a añadir código en "network.gd" para unir un cliente a un servidor:

```
# File: network.gd

signal server_created                          # when server is successfully created
signal join_success                            # When the peer successfully joins a server
signal join_fail                               # Failed to join a server

func join_server(ip, port):
	var net = NetworkedMultiplayerENet.new()

	if (net.create_client(ip, port) != OK):
		print("Failed to create client")
		emit_signal("join_fail")
		return

	get_tree().set_network_peer(net)

# Peer trying to connect to server is notified on success
func _on_connected_to_server():
	emit_signal("join_success")

# Peer trying to connect to server is notified on failure
func _on_connection_failed():
	emit_signal("join_fail")
	get_tree().set_network_peer(null)
```

Ahora hay que modificar "main_menu" para invocar la función anterior desde el "btnJoin".

```
# File: main_menu.gd

func _ready():
	network.connect("server_created", self, "_on_ready_to_play")
	network.connect("join_success", self, "_on_ready_to_play")
	network.connect("join_fail", self, "_on_join_fail")

func _on_join_fail():
	print("Failed to join server")

func _on_btJoin_pressed():
	var port = int($PanelJoin/txtJoinPort.text)
	var ip = $PanelJoin/txtJoinIP.text
	network.join_server(ip, port)
```

## 2.4 Probar las conexiones

Para poder comprobar lo que tenemos:
* Exportar el proyecto y crear un ejecutable.
* Ejecutar el proyecto desde el editor, para usarlo como servidor.
* Ejecutar la aplicación desde el ejecutable para usarlo como cliente.

[next >>](multiplayer-n-3.md)
