
[<< back](multiplayer-n.md)

# 3. Sincronización

Sincronizando los objetos dentro del "game world".

## 3.1 Listado de jugadores

Vamos tratar de mostrar un listado de jugadores conectados, y crearemos una escena "player" que usaremos para representar al avatar del jugador en el "game world".

```
# File: gamestate.gd

var player_info = {
	name = "Player",                   # How this player will be shown within the GUI
	net_id = 1,                        # By default everyone receives "server ID"
	actor_path = "res://player.tscn",  # The class used to represent the player in the game world
	char_color = Color(1, 1, 1)        # By default don't modulate the icon color
}
```

El código anterior da la posibilidad de que cada jugador use una escena diferente, personalizando el valor de "actor_path". Aunque no se usará en este ejemplo.

```
# File: network.gd

signal server_created                          # when server is successfully created
signal join_success                            # When the peer successfully joins a server
signal join_fail                               # Failed to join a server
signal player_list_changed                     # List of players has been changed

var players = {}


func _on_connected_to_server():
	emit_signal("join_success")
	# Update the player_info dictionary with the obtained unique network ID
	gamestate.player_info.net_id = get_tree().get_network_unique_id()
	# Request the server to register this new player across all connected players
	rpc_id(1, "register_player", gamestate.player_info)
	# And register itself on the local list
	register_player(gamestate.player_info)

remote func register_player(pinfo):
	if (get_tree().is_network_server()):
		# We are on the server, so distribute the player list information
		# throughout the connected players
		for id in players:
			# Send currently iterated player info to the new player
			rpc_id(pinfo.net_id, "register_player", players[id])
			# Send new player info to currently iterated player, skipping the server
			if (id != 1):
				rpc_id(id, "register_player", pinfo)

	# Now to code that will be executed regardless of being on client or server
	print("Registering player ", pinfo.name, " (", pinfo.net_id, ") to internal player table")
	players[pinfo.net_id] = pinfo          # Create the player entry in the dictionary
	emit_signal("player_list_changed")     # And notify that the player list has been changed

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
	# Register the server's player in the local player list
	register_player(gamestate.player_info)
```

* Cuando se crea el servidor, se registra así mismo en la lista de "players".
* Cada vez que se conecta un nuevo jugador se registra ("register_player") la nueva información, y se envían las novedades al resto de clientes conectados.


## 3.2 Player List HUD

Cuando se emite el evento "player_list_changed", se debe actualizar el listado en la ventana.

```
# File: game_world.gd

func _ready():
	# Connect event handler to the player_list_changed signal
	network.connect("player_list_changed", self, "_on_player_list_changed")

	# Update the lblLocalPlayer label widget to display the local player name
	$HUD/PanelPlayerList/lblLocalPlayer.text = gamestate.player_info.name

func _on_player_list_changed():
	# First remove all children from the boxList widget
	for c in $HUD/PanelPlayerList/boxList.get_children():
		c.queue_free()

	# Now iterate through the player list creating a new entry into the boxList
	for p in network.players:
		if (p != gamestate.player_info.net_id):
			var nlabel = Label.new()
			nlabel.text = network.players[p].name
			$HUD/PanelPlayerList/boxList.add_child(nlabel)
```

* Cuando se crea el servidor o nos unimos como cliente, hay que actualizar "player_info". Para eso usaremos la función "set_player_info()".

```
func set_player_info():
	if (!$PanelPlayer/txtPlayerName.text.empty()):
		gamestate.player_info.name = $PanelPlayer/txtPlayerName.text
	gamestate.player_info.char_color = $PanelPlayer/btColor.color

func _on_btCreate_pressed():
	# Properly set the local player information
	set_player_info()

	# Gather values from the GUI and fill the network.server_info dictionary
	if (!$PanelHost/txtServerName.text.empty()):
		network.server_info.name = $PanelHost/txtServerName.text
	network.server_info.max_players = int($PanelHost/txtMaxPlayers.value)
	network.server_info.used_port = int($PanelHost/txtServerPort.text)

	# And create the server, using the function previously added into the code
	network.create_server()

func _on_btJoin_pressed():
	# Properly set the local player information
	set_player_info()

	var port = int($PanelJoin/txtJoinPort.text)
	var ip = $PanelJoin/txtJoinIP.text
	network.join_server(ip, port)
```

* Podemos exportar el proyecto y comprobar lo nuevos cambios.

## 3.3 Unregistering

```
# FIle: network.gd

remote func unregister_player(id):
	print("Removing player ", players[id].name, " from internal table")
	# Remove the player from the list
	players.erase(id)
	# And notify the list has been changed
	emit_signal("player_list_changed")

func _on_player_disconnected(id):
	print("Player ", players[id].name, " disconnected from server")
	# Update the player tables
	if (get_tree().is_network_server()):
		# Unregister the player from the server's list
		unregister_player(id)
		# Then on all remaining peers
		rpc("unregister_player", id)

func _on_disconnected_from_server():
	print("Disconnected from server")
	# Clear the internal player list
	players.clear()
	# Reset the player info network ID
	gamestate.player_info.net_id = 1
```

## 3.4 Player Scene

Hemos sincronizado la lista de jugadores entre las máquinas conectadas, ahora añadiremos objetos que "player" en "game world", y los sincronizaremos también entre todas las máquinas.

* Creamos la escena "player.tscn" con nodo raíz del tipo "Node2D".
* Añadimos la imagen "icon.png".
* Agregamos un GDScript "player.gd" que tendrá el código necesario para modificar el color del Sprite y leer las entradas de teclado para mover el objeto Player.

```
# File: player.gd

var move_speed = 300

func set_dominant_color(color):
	$icon.modulate = color

func _process(delta):
	# Initialize the movement vector
	var move_dir = Vector2(0, 0)

	# Poll the actions keys
	if (Input.is_action_pressed("move_up")):
		# Negative Y will move the actor UP on the screen
		move_dir.y -= 1
	if (Input.is_action_pressed("move_down")):
		# Positive Y will move the actor DOWN on the screen
		move_dir.y += 1
	if (Input.is_action_pressed("move_left")):
		# Negative X will move the actor LEFT on the screen
		move_dir.x -= 1
	if (Input.is_action_pressed("move_right")):
		# Positive X will move the actor RIGHT on the screen
		move_dir.x += 1

	# Apply the movement formula to obtain the new actor position
	position += move_dir.normalized() * move_speed * delta
```

Ahora hay que hacer aparecer (spawn) al Player.

* Cuando se crea el servidor hay que crear el primer Player.
* Cada vez que un cliente se une al servidor, todas las máquinas conectadas deben recibir la orden para crear la nueva instancia Player.
* Para no usar la misma spawn position, usaremos un array de posiciones.

```
# File:  game_world.gd

# Spawns a new player actor, using the provided player_info structure and the given spawn index
remote func spawn_players(pinfo, spawn_index):
	# If the spawn_index is -1 then we define it based on the size of the player list
	if (spawn_index == -1):
		spawn_index = network.players.size()

	if (get_tree().is_network_server() && pinfo.net_id != 1):
		# We are on the server and the requested spawn does not belong to the server
		# Iterate through the connected players
		var s_index = 1      # Will be used as spawn index
		for id in network.players:
			# Spawn currently iterated player within the new player's scene, skipping the new player for now
			if (id != pinfo.net_id):
				rpc_id(pinfo.net_id, "spawn_players", network.players[id], s_index)

			# Spawn the new player within the currently iterated player as long it's not the server
			# Because the server's list already contains the new player, that one will also get itself!
			if (id != 1):
				rpc_id(id, "spawn_players", pinfo, spawn_index)

			s_index += 1

	# Load the scene and create an instance
	var pclass = load(pinfo.actor_path)
	var nactor = pclass.instance()
	# Setup player customization (well, the color)
	nactor.set_dominant_color(pinfo.char_color)
	# And the actor position
	nactor.position = $SpawnPoints.get_node(str(spawn_index)).position
	# If this actor does not belong to the server, change the node name and network master accordingly
	if (pinfo.net_id != 1):
		nactor.set_network_master(pinfo.net_id)
	nactor.set_name(str(pinfo.net_id))
	# Finally add the actor into the world
	add_child(nactor)
```

Ya tenemos la función que hace aparecer el player, ahora vemos cómo se invoca:

```
# File: game_world.gd

func _ready():
	# Connect event handler to the player_list_changed signal
	network.connect("player_list_changed", self, "_on_player_list_changed")

	# Update the lblLocalPlayer label widget to display the local player name
	$HUD/PanelPlayerList/lblLocalPlayer.text = gamestate.player_info.name

	# Spawn the players
	if (get_tree().is_network_server()):
		spawn_players(gamestate.player_info, 1)
	else:
		rpc_id(1, "spawn_players", gamestate.player_info, -1)
```

## 3.5 Sincronizando los player

Tenemos dos problemas que resolver:
* Al mover un jugador se nos mueven todos.
* Los cambios de posición no se están sincronizando entre las máquinas.

```
# File: player.gd

slave var repl_position = Vector2()

func _process(delta):
	if (is_network_master()):
		# Initialize the movement vector
		var move_dir = Vector2(0, 0)

		# Poll the actions keys
		if (Input.is_action_pressed("move_up")):
			# Negative Y will move the actor UP on the screen
			move_dir.y -= 1
		if (Input.is_action_pressed("move_down")):
			# Positive Y will move the actor DOWN on the screen
			move_dir.y += 1
		if (Input.is_action_pressed("move_left")):
			# Negative X will move the actor LEFT on the screen
			move_dir.x -= 1
		if (Input.is_action_pressed("move_right")):
			# Positive X will move the actor RIGHT on the screen
			move_dir.x += 1

		# Apply the movement formula to obtain the new actor position
		position += move_dir.normalized() * move_speed * delta

		# Replicate the position
		rset("repl_position", position)
	else:
		# Take replicated variables to set current actor state
		position = repl_position
```

Tenemos que crear otra función para hacer "despawning" cuando se desconecta un cliente:

```
# File: game_world.gd

remote func despawn_player(pinfo):
	if (get_tree().is_network_server()):
		for id in network.players:
			# Skip disconnecte player and server from replication code
			if (id == pinfo.net_id || id == 1):
				continue

			# Replicate despawn into currently iterated player
			rpc_id(id, "despawn_player", pinfo)

	# Try to locate the player actor
	var player_node = get_node(str(pinfo.net_id))
	if (!player_node):
		print("Cannoot remove invalid node from tree")
		return

	# Mark the node for deletion
	player_node.queue_free()
```

* Creamos evento "player_removed".

```
# File: network.gd

signal server_created                          # when server is successfully created
signal join_success                            # When the peer successfully joins a server
signal join_fail                               # Failed to join a server
signal player_list_changed                     # List of players has been changed
signal player_removed(pinfo)                   # A player has been removed from the list


remote func unregister_player(id):
	print("Removing player ", players[id].name, " from internal table")
	# Cache the player info because it's still necessary for some upkeeping
	var pinfo = players[id]
	# Remove the player from the list
	players.erase(id)
	# And notify the list has been changed
	emit_signal("player_list_changed")
	# Emit the signal that is meant to be intercepted only by the server
	emit_signal("player_removed", pinfo)
```

```
# File: game_world.gd

func _ready():
	# Connect event handler to the player_list_changed signal
	network.connect("player_list_changed", self, "_on_player_list_changed")
	# If we are in the server, connect to the event that will deal with player despawning
	if (get_tree().is_network_server()):
		network.connect("player_removed", self, "_on_player_removed")

	# Update the lblLocalPlayer label widget to display the local player name
	$HUD/PanelPlayerList/lblLocalPlayer.text = gamestate.player_info.name

	# Spawn the players
	if (get_tree().is_network_server()):
		spawn_players(gamestate.player_info, 1)
	else:
		rpc_id(1, "spawn_players", gamestate.player_info, -1)

func _on_player_removed(pinfo):
	despawn_player(pinfo)
```

En el siguiente apartado vamos a crear unos "bots" para rellenar "game world" cuando no haya suficientes jugadores conectados.
