
# Multiplayer game

Vamos a ver un ejemplo sencillo para crear un juego para dos 2 jugadores simultáneos, usando las utilidades de red que proporciona el propio Godot Engine ([Ver código](../../demos/multiplayer)).

1. Escena [lobby](#lobby)
2. Escena [level1](#level1)
3. Escena [player](#player)

## 1. Lobby

Empezaremos creando una escena `lobby` que se encargará de establecer las conexiones de red entre dos máquinas (programas). Un programa se ejecutará en una máquina teniendo la función de **servidor de red**, y el mismo programa se ejecutará en otra máquina diferente teniendo la función de **cliente de red**.

* Al ejecutar el programa, se inicia la escena `lobby`, mostrando una ventana para decidir si queremos iniciar el programa en modo servidor o cliente de red.
* Si pulsamos el botón `host_button` se ejecuta la función siguiente para activar el modo servidor de red aunque el servidor se queda esperando a que se conecte 1 cliente:

```
func _on_host_button_pressed():
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	var err = host.create_server(DEFAULT_PORT, 1) # Maximum of 1 peer, since it's a 2-player game.

	get_tree().set_network_peer(host)
```
* Si estamos en la máquina cliente y ejecutamos el programa seleccionando la opción `join_button` se ejecutará la siguiente función para activar el modo cliente de red.

```
func _on_join_button_pressed():
	var ip = address.get_text()
	var host = NetworkedMultiplayerENet.new()
	host.set_compression_mode(NetworkedMultiplayerENet.COMPRESS_RANGE_CODER)
	host.create_client(ip, DEFAULT_PORT)
	get_tree().set_network_peer(host)
```

* El servidor que estaba esperando por el cliente, se activa y se ejecuta la siguiente función que carga el juego (Escena `level1`):

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
