
# Multiplayer N jugadores

> Enlaces de interés:
> * Scratch [Godot 3 Tutorial– Networking](https://gamefromscratch.com/godot-3-tutorial-networking/)
> * Zerosploit [Godot 3 Multiplayer - High Level Networking - Part 1](https://www.youtube.com/watch?v=TGIWD24QIvY)
> * Menip [tutorials](https://gitlab.com/menip/godot-multiplayer-tutorials)

_Traducción al español del artículo "Kehom's Forge - Multiplayer Game Setup in Godot"
(http://kehomsforge.com/tutorials/multi/gdMultiplayerSetup/)_

## Introducción

En este tutorial vamos a ver los pasos necesarios para configurar un juego multiusuario en Godot para un número N de jugadores.

En la mayoría de tutoriales se trabaja con un "lobby" para establecer las conexiones entre los participantes. Esto es, en el "lobby" nos quedaríamos todos esperando hasta completar el número de jugadores conectados antes de empezar a jugar. Pero en este tutorial, no vamos a tener un "lobby". Una vez se establece la conexión, inmediatamente entramos a jugar sin esperar por el resto de participantes.

Cuando se inicia el "juego" empezamos con un menú principal donde podemos elegir:
* Crear un servidor o unirnos como cliente a un servidor existente.
* Personalizar nuestro color.

Cuando creamos el servidor, podemos establecer:
* La cantidad máxima de jugadores que se podrán conectar.
* El número del puerto de conexión.

Una vez creado el servidor, pasamos a la escena del juego y a mostrar el jugador.
Más adelante, completaremos con "bots" hasta llegar al número máximo de jugadores.

En resumen, este tutorial abarcará lo siguiente:
* Inicialización de red.
* Sincronización entre los "actors" y el "game world".
* Lógica para rellenar el juego con bots.

Estructura del tutorial:
1. Sistema de red de lto nivel de Godot: Breve repaso de las características del sistema de red que proporciona Godot. Configuraremos la base de nuestro proyecto.
2. Menú principal: Trabajaremos con el menú principal y usaremos el código base de red para crear el servidor o unirnos a uno.
3. Sincronización: Crearemos un sistema de gestión de jugadores sencilla que nos permita mostrar los jugadores conectados. Luego colocaremos cada jugador en el mundo del juego y los sincronizaremos entre ellos.
4. Bots: Añadiremos una inteligencia artificial rudimentaria para los "bots" que se usarán para completar el número máximo de jugadores. Todo además sincronizado entre los jugadores conectados.

> Se puede [descargar el código del proyecto](https://github.com/Kehom/gdMultiplayerTutorial)

# 1 - Sistema de red de alto nivel de Godot

> Enlace de interés:
* [Godot’s networking documentation](https://docs.godotengine.org/en/3.1/tutorials/networking/index.html)

El sistema de red de alto nivel de Godot recae en la clase "NetworkedMultiplayerENet". La usaremos para crear el servidor y los clientes. Cuando la conexión está establecida podemos invocar la ejecución de funciones en las máquinas remotas usando llamadas RPC (Remote Procedura Call). Además, para que una función pueda ser invocada de forma remota debe estar definida con la palabra clave "remote".

```
remote func function_name(arguments):
	function code
```

Tenemos las siguientes métodos para invocar una función remota:
* **rpc()**: Llama a una función remota de todos los equipos remotos y también en el equipo local. Pero nunca llama a una función del servidor.
* **rpc_id()**: Llama a una función remota de una determinada máquina (ID). Debemos tener cuidado para no usarla con nuestro ID local.
* **rpc_unreliable()**: Funciona de forma similar a "rpc()"", pero usando un protocolo de red (UDP) no confiable pero mucho más rápido.
* **rpc_unreliable_id()**: Funciona de forma similar a "rpc_id()", pero usando un protocolo de red no confiable pero mucho más rápido.

Si declaramos las variables de la siguiente forma:

```
slave var variable_name
```

También podemos mantener sincronizados su valores entre las diferentes máquinas usando las siguientes funciones:

* **rset()**: Cambia el valor de la variable en todas las máquinas remotas y localmente.
* **rset_id()**: Es similar a "rset()" pero sólo se ejecuta en la máquina especificada (ID).
* **rset_unreliable()**: Es similar a "rset()" pero usando un protocolo más rápido.
* **rset_unreliable_id()**: Es similar a "rest_id()" pero usando un protocolo más rápido.


## 1.1 Configuración del proyecto

* Creamos un proyecto nuevo de Godot.
* Nuestra primera escena se llamará "main_menu". Tendrá un nodo raíz de tipo "CanvasLayer" y la grabamos como "main_menu.tscn" y la configuramos para que sea nuestra escena inicial del proyecto.
* Ahora creamos una escena llamada "game world". Tendrá un nodo raíz de tipo "Node2D" y la grabamos como game_world.tscn".
* Usaremos singletons para guardar el código de red y el estado del juego. Crearemos los ficheros "gamestate.gd" y "network.gd" heredando de Node:

```
extends Node
```

* Ir a configuraciones del proyecto -> Autoload, y añadir "gamestate.gd" y "network.gd" como singletons

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

En la siguiente sección añadiremos algo a nuestro "game world".
