
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
