
[<< back](../README.md)

# Multiplayer N jugadores

> Enlaces de interés:
> * Scratch [Godot 3 Tutorial– Networking](https://gamefromscratch.com/godot-3-tutorial-networking/)
> * Zerosploit [Godot 3 Multiplayer - High Level Networking - Part 1](https://www.youtube.com/watch?v=TGIWD24QIvY)
> * Menip [tutorials](https://gitlab.com/menip/godot-multiplayer-tutorials)

_Traducción al español del artículo "Kehom's Forge - Multiplayer Game Setup in Godot"
(http://kehomsforge.com/tutorials/multi/gdMultiplayerSetup/)_

## Introducción

Vamos a ver los pasos para configurar un juego en red con Godot para un número N de jugadores.

Muchos proyectos usan una escena "lobby", donde nos quedamos esperando hasta se hayan establecido las conexiones entre todos los participantes. En esta guía no vamos a tener un "lobby". Una vez que se establece la conexión, entramos a jugar inmediatamente sin esperar por el resto de participantes. Esto nos permite tener una cantidad variable de participantes.

El juego se inicia con un menú principal donde podemos:
* Personalizar nuestro nombre y color.
* Crear un servidor de red o unirnos como cliente a un servidor existente.


En resumen, este tutorial abarcará lo siguiente:
* Inicialización de red.
* Sincronización entre los "actors" y el "game world".
* Lógica para rellenar el juego con bots.

Estructura del tutorial:
1. **Sistema de red de alto nivel de Godot**: Breve repaso de las características del sistema de red que proporciona Godot.
2. **Menú principal**: En el menú principal se establece la conexión de red con el servidor o se crea el servidor si somos el primer jugador.
3. **Sincronización**: Crearemos las escenas "game_world" y "player" para tener un mundo de juego y jugadores. Lo más importante es ver cómo se sincronizan estas escenas entre todas las máquinas.
4. **Bots**: Si no tenemos suficientes jugadores dentro del juego, completaremos añadiendo "bots" con una inteligencia muy básica. Además estos "bots" deben estar sincronizados entre todas las máquinas.

> Se puede [descargar el código del proyecto](https://github.com/Kehom/gdMultiplayerTutorial)

# 1 - Sistema de red de alto nivel de Godot

> Enlace de interés:
* [Godot’s networking documentation](https://docs.godotengine.org/en/3.1/tutorials/networking/index.html)

El sistema de red de alto nivel de Godot se lleva a cabo en la clase **NetworkedMultiplayerENet**. Nos permitirá crear el servidor de red y las conexiones de los clientes. Si definimos una función con la palabra clave "remote", podremos invocar su ejecución en las máquinas remotas usando llamadas RPC (Remote Procedure Call).

```
remote func function_name(arguments):
	function code
```

Tenemos las siguientes métodos para invocar una función remota:
* **rpc()**: Llama a una función remota de todos las máquinas y también en el equipo local. Pero nunca llama a una función del servidor.
* **rpc_id()**: Llama a una función remota de una determinada máquina (ID). Debemos tener cuidado para no usarla con nuestro ID local.
* **rpc_unreliable()**: Funciona de forma similar a "rpc()"", pero usando un protocolo de red (UDP) no confiable pero mucho más rápido.
* **rpc_unreliable_id()**: Funciona de forma similar a "rpc_id()", pero usando un protocolo de red no confiable pero mucho más rápido.

Si declaramos las variables de la siguiente forma:

```
slave var variable_name
```

Podemos mantener sincronizados su valores entre las diferentes máquinas usando las siguientes funciones:

* **rset()**: Cambia el valor de la variable en todas las máquinas remotas y localmente.
* **rset_id()**: Es similar a "rset()" pero sólo se ejecuta en la máquina especificada (ID).
* **rset_unreliable()**: Es similar a "rset()" pero usando un protocolo más rápido.
* **rset_unreliable_id()**: Es similar a "rest_id()" pero usando un protocolo más rápido.


## 1.1 Configuración del proyecto

* Creamos un proyecto nuevo de Godot.
* Nuestra primera escena se llamará "main_menu". Tendrá un nodo raíz de tipo "CanvasLayer" y la grabamos como "main_menu.tscn". La configuramos para que sea nuestra escena inicial del proyecto.
* Ahora creamos una escena llamada "game world". Tendrá un nodo raíz de tipo "Node2D" y la grabamos como "game_world.tscn".
* Usaremos singletons para guardar el código de red y el estado del juego. Crearemos los ficheros "gamestate.gd" y "network.gd" heredando de Node:

```
extends Node
```

* Ir a configuraciones del proyecto -> Autoload, y añadir "gamestate.gd" y "network.gd" como singletons

[next >>](multiplayer-n-2.md)
