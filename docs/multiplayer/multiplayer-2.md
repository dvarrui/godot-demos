
# Multiplayer - 2 jugadores

> Enlaces de interés:
> * [Pong multijugador](
https://github.com/godotengine/godot-demo-projects/tree/master/networking/multiplayer_pong/)
> * [Godot dedicated server tutorial](https://mrminimal.gitlab.io/2018/07/26/godot-dedicated-server-tutorial.html)

Vamos a ver un ejemplo sencillo para crear una estructura de juego en red para dos 2 jugadores simultáneos, usando las utilidades de red que proporciona el propio Godot Engine a través de la clase NetworkedMultiplayerENet que proporciona un API de red de alto nivel ([Ver código del ejemplo](../../demos/multiplayer)).

El código de nuestro ejemplo lo estructuramos en las siguientes partes:
1. Escena [lobby](#lobby)
2. Escena [level1](#level1)
3. Escena [player](#player)

## 1. Lobby

Empezaremos con una escena `lobby` que se encargará de establecer las conexiones de red entre dos máquinas (o dos instancias del mismo programa). Un programa se ejecutará en una máquina (MV1) teniendo la función de **servidor de red**, y el mismo programa se ejecutará en otra máquina diferente (MV2) teniendo la función de **cliente de red**. El código del programa es el mismo para servidor y cliente, pero se añaden condicionales para diferenciar ambos comportamientos.

* Al ejecutar el programa, se inicia la escena `lobby`, que muestra una ventana donde podemos decidir iniciar el programa en modo servidor o en modo cliente de red.
* Si pulsamos el botón `host_button` se ejecuta el código para activar el modo servidor de red aunque el servidor se quedará esperando a que se conecte 1 cliente. Veamos el código:

```
func _on_host_button_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)

	# Maximum of 1 peer, since it's a 2-player game.
	var err = host.create_server(DEFAULT_PORT, 1)

	get_tree().set_network_peer(host)
```

* Vamos a la máquina cliente (MV2). Al ejecutar el programa seleccionando la opción `join_button` estableceremos conexión con el servidor (MV1) pero estando en modo cliente de red. Veamos el código:

```
func _on_join_button_pressed():
	var ip = address.get_text()
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)

	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
```

* El servidor que estaba esperando por el cliente, ejecuta la función `_player_connected(id)` cuando se conecta el cliente. En ahora cuando comienza el juego. Podemos comprobar cómo el código carga la escena `level1` que será la que contendrá el código del juego.

```
# Callback from SceneTree.
func _player_connected(_id):
	# Someone connected, start the game!
	var level = load("res://level/level1.tscn").instance()
	# Connect deferred so we can safely erase it from the callback.
	level.connect("game_finished", self, "_end_game", [], CONNECT_DEFERRED)

	get_tree().get_root().add_child(level)
	hide()
```

## 2. Level1

Para hacer esta guía lo más simple posible, tenemos que la escena `level1` sólo tiene 2 nodos (player1 y player2), ambos instancias de una escena `player` creada por nosotros.

```
extends Node2D

signal game_finished()

onready var player1 = $player1
onready var player2 = $player2

func _ready():
	# By default, all nodes in server inherit from master,
	# while all nodes in clients inherit from puppet.
	# set_network_master is tree-recursive by default.
	if get_tree().is_network_server():
		# For the server, give control of player 2 to the other peer.
		player2.set_network_master(get_tree().get_network_connected_peers()[0])
	else:
		# For the client, give control of player 2 to itself.
		player2.set_network_master(get_tree().get_network_unique_id())

func _process(delta):
	if Input.is_action_pressed("game_exit"):
		emit_signal("game_finish")
```

* Configuramos el nodo `player2` se para que sea controlado por un master con un ID determinado. Esto es, el ID del cliente. El servidor tiene siempre el ID 1, y los clientes un ID único con valor > 1.
* La forma de averiguar el ID del cliente es diferente según la máquina en que estemos:
    * MV1 (servidor): get_tree().get_network_connected_peers()[0]
		* MV1 (cliente): get_tree().get_network_unique_id()

Ahora tenemos que player2 está controlado por el cliente.

## 3. Player

Tendremos 2 nodos de tipo Player, uno que se ejecutará en el servidor (player1) y el otro en el cliente (player2). Por tanto, el código de las escena Player debe tenerlo en cuenta:

```
extends Node2D

var speed = 300
var motion = Vector2.ZERO

func _process(delta):

	# Is the master of the paddle.
	if is_network_master():
		var dir = Vector2.ZERO
		if Input.is_action_pressed("player_left"):
			dir += Vector2(-1, 0)
		if Input.is_action_pressed("player_right"):
			dir += Vector2(1, 0)
		if Input.is_action_pressed("player_up"):
			dir += Vector2(0, -1)
		if Input.is_action_pressed("player_down"):
			dir += Vector2(0, 1)

		motion = dir * speed * delta
		# Using unreliable to make sure position is updated as fast
		# as possible, even if one of the calls is dropped.
		rpc_unreliable("set_pos_and_motion", position, motion)

	translate(motion)

# Synchronize position and speed to the other peers.
puppet func set_pos_and_motion(p_pos, p_motion):
	position = p_pos
	motion = p_motion
```

* `motion` es una variable Vector2 que define la cantidad de movimiento (traslación) que va a tener esta escena.
* La función `_process()` se ejecuta en MV1 y MV2, pero como MV1 es el master de player1, player1 sólo responde a las órdenes del teclado realizadas en la MV1. Lo mismo con player2. El master de player2 es la MV2, por lo que sólo responderá a las entradas de teclado producidas en la MV2.
* Cuando player2 tiene un cambio de `motion` en MV2, invoca la función `rpc_unreliable("set_pos_and_motion", position, motion)` para enviar estos datos al servidor MV1. Cuando el sevidor MV1 recibe la llamada, invoca el método `set_pos_and_motion` para informar en el servidor del cambio que se ha producido.
* Recordar que el juego se está ejecutando en MV1 y MV2. Hay copia de los nodos level1, player1 y player2 en MV1 y MV2. El cliente controla player2 y hace sus cambios en local pero debe informar al servidor para que actualice su copia.

## Resumen

* Cuando se establece la conexión de red entre el servidor (MV1) y el cliente (MV2), ambos ejecutan el mismo juego con la misma estructura de nodos (lobby, level1, player1 y player2).
* Algunos de estos nodos serán controlados por el servidor (level1, player1) y otros por el cliente (player2). Esto se consigue definiendo el "master" de cada nodo con su ID correspondiente.
* Para probar nuestro juego en red, lo ejecutaremos en dos máquinas diferentes.

|        | MV1      | MV2     |
| ------ | -------- | ------- |
| Modo   | Servidor | Cliente |
| ID     | 1        | 2       |
| Nodos  | lobby, level1, player1, player2 | lobby, level1, player1, player2 |
| Master | level1, player1 | player2 |
