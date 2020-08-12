
[<< back](multiplayer-n.md)

# 2. Menú principal

Vamos a diseñar una ventana principal ("main_menu") sencilla para poder elegir lo siguiente:
* Información del jugador: Nombre y color de su avatar.
* Información para crear el servidor: nombre, número máximo de clientes (Entre 2 y 16), puerto (por defecto 4546).
* Información para crear el cliente de red: IP del servidor y puerto (Por deefcto 4546).

## 2.1 Eventos de red

Veamos algunos eventos que genera el sistema de red de Godot:
* **connected_to_server()**: Se emite cuando un cliente se une al servidor.
* **connection_failed()**: Cuando falla el intento de un ciente de unirse a un servidor
* **network_peer_connected(id)**: Se envía a todos los conectados al servidor cuando se une un nuevo cliente. ID es el identificador del nuevo cliente.
* **network_peer_disconnected(id)**: Cuando el cliente ID se desconecta del servidor, se envía esta señal a todo el mundo.
* **server_disconnected()**: Evento recibio por un cliente cuando se desconecta del servidor.

Para estar atentos a estos eventos de red y responder en consecuencia debemos hacer dos cosas:

* (a) crear unas funciones con el código de respuesta.

```
# File: network.gd

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

* , y (b) conectar las señales (eventos) a dichas funciones.

```
# File: network.gd

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_player_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_on_disconnected_from_server")
```

## 2.2 Crear el servidor

Vamos a crear el código necesario en "network.gd" para crear el servidor de red.

```
#File: network.gd

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

La función anterior se invocará desde el "main_menu", cuando se pulse el botón "btCreate".

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

Cuando se pulse el botón de crear servidor, si se ha creado correctamente se emite la señal "server_created" que cuando se recibe hará que se cargué la escena principal del juego "game_world.tscn".

## 2.3 Unirse a un servidor

Creamos el código de red necesario para unir un cliente a un servidor:

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

Ahora modificamos "main_menu" para poder invocar la función anterior desde el "btnJoin".

We now can join a server, we just need to call this function from the main menu! Ok, we also need to listen to the signals telling about success or failure. So, let’s first connect them. For the success we will reuse the `_on_ready_to_play()` function, although it would be a good idea to separate that into a different function if there is any need to perform different tasks based on wether we are creating or joining a server. As for the failure we will create a new function shortly. The connections:

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
* Ejecutar el proyecto desde el ejecutable para usarlo como cliente.

En la siguiente sección añadiremos objetos a nuestro "game world" y los sincronizaremos entre todas las máquinas.

[next >>](multiplayer-n-3.md)
