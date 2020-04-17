[<< back](README.md)

# Preparativos

## Instalar software

Vamos a instalar el motor GodotEngine (versión 3.2)
* Creamos una carpeta `godot`
* Descargamos un fichero zip de la web godotengine.org.
* Creamos la carpeta `godot/bin` y descomprimos el fichero.
* Como resultado tendremos el ejecutable de Godot, que ya se puede usar.

Otro software recomendado:
* Instalar GIMP (Software de edición de gráficos). Lo podemos descargar de la página web de www.gimp.org.

## Roles

Para crear un videojuegos hay muchos caminos. Podemos hacer un desarrollo Indie, donde nos encargamos de hacerlo todo sin ayuda de nadie. O también podemos estar en una gran empresa de creación de juegos donde formamos parte de un gran equipo y cada uno se encarga de una pequeña parte. De hecho hay muchas funciones diferentes a la hora de crear un juego, pero nosotros lo vamos a simplificar en 3 roles:
1. Rol del artista
1. Rol del programador
1. Rol del diseñador del juego

El artista es el encargado de crear los gráficos, sprites, texturas, modelos 3D,etc. El programador se encarga de... programar. Y el diseñador del juego es quien tiene la idea de cómo debe ser el juego. El diseñador es el creativo que da instrucciones a los artistas y programadores para llevar a cabo el proyecto.

En esta serie de tutoriales, sólo nos vamos a centrar en el rol del programador. En la parte artística haremos uso de recursos con licencia libre y el la parte de diseño... bueno ahí vamos a ser poco originales y vamos a imitar otros diseños que ya existen. Porque nos vamos a centrar en el rol del programador.

## Organizando las carpetas

* Creamos el siguiente directorio `godot/demo/roguelike`.
* Iniciamos `godot -> Nuevo proyecto`.
* `Examinar` para buscar la carpeta `godot/demo/roguelike` y `Seleccionar carpeta`
* Poner nombre al proyecto `Roguelike`.
* `Crear y editar`
* Usando el propio editor de Godot, vamos a crear la siguiente estructura de directorios para nuestro proyecto:
```
├── actor
│   ├── enemy
│   └── player
├── assets
│   ├── actors
│   ├── objects
│   └── tiles
├── level
└── object
```

## Assets

Los assets son los recursos tanto gráficos como de sonido o música, que hacen los artistas, y que necesitaremos en nuestro juego. Existen algunas web donde podemos descargar assets con licencia libre, por ejemplo:
* [Kenney](https://www.kenney.nl/)
* [Game-Icons.net](https://game-icons.net/)
* spriter-resource
* itch.io
* vg-resource

En nuestro proyecto vamos usar un conjunto de assets de Kenney:
* Crear la carpeta `godot/assets`.
* Descargar de la web de Kenney, los assets de **miniroguelike** en la carpeta anterior.

Ahora tenemos todos los assets que nos hemos descargado en `godot/assets`. Después de revisarlos, vamos a escoger sólo aquellos que nos hacen falta y lo vamos a copiar dentro de nuestro proyecto de Godot, de la siguiente forma:

| Carpeta | Ficheros | Descripción |
| ------- | -------- | ----------- |
| demos/roguelike/assets |  Instructions.url, Kenney.url, License.txt y Patreon.url | Respetar la licencia del autor |
| demos/roguelike/assets/actors | tile 0004, 0014, 0015, 0016, 0017, 0019, 0080 | Personajes (player y enemigos) |
| demos/roguelike/assets/objects | tile 0034, 0039, y 0057 | Objetos del juego |
| demos/roguelike/assets/tiles | Desde tile 0000 hasta tile 89 | Tiles para formar el mapa |

---
## Creando la primera escena

En Godot se utilizan las escenas y los nodos para crear el juego.
* Las escenas las usamos para crear cada elemento del juego de forma independiente. Al final haremos un escena que contenga al resto y ya tenemos el juego. Las escenas serían como clases en programación orientada a objetos.
* Los nodos dan funcionalidad o habilidades a las escenas. En principio vamos a usar los nodos que nos proporciona Godot y si nos falta algún nodo más siempre podremos crear los nuestros a medida.

Vamos a crear la primera escena del juego.
* Usamos el símbolo `+` para añadir nuevos nodos a la escena.
* Elegimos **Node2D** porque es la base para empezar un juego 2D. Renombrar el nodo a `level`.
* Escena guardar como `res::/level/level1.tscn`.
* Pulsar F5 para ejecutar el juego (Bueno, por ahora sólo tenemos una pantalla en gris oscuro).

> NOTA:
> * F5 => probar el juego desde el principio
> * F6 => probar escena actual

## Player

Ahora vamos a crear otra escena, para crear a nuestro personaje principal.
* `Escenas -> Nueva escena`
* En la ventana "árbol de nodos" vamos a añadir los siguientes nodos:

![](images/player-node-tree.png)

* Empezamos con un nodo raíz de tipo **KinematicBody2D** al que hemos renombrado como `player` (Recordar que usamos el símbolo `+` para añadir nodos a la escena).

> Hemos elegido este nodo porque nos proporciona comportamiento de un cuerpo físico. Lo necesitamos para conseguir el efecto de colisiones con el resto de cuerpos físicos de la escena (Como por ejemplo, las paredes de la mazmorra).

* Añadir un nodo hijo de tipo **Sprite** al que renombraremos como `sprite`.
* Seleccionando el nodo `sprite`, vemos en la ventana inspector las propiedades de este nodo. En la propiedad **texture** vamos a cargar la imagen `assets/actor/tile_004.png`.

> Hemos añadimos un nodo **Sprite** para incorporar imágenes 2D a nuestra escena.

* Añadir otro nodo hijo al nodo raíz, de tipo **CollisionShape2D** y lo renombramos como `shape`.
* Seleccionando el nodo `shape`, vamos a la ventana inspector y en la propiedad Shape elegir `RectangleShape2D`. Ajustamos el tamaño del rectángulo para ajustarlo lo mejor posible al tamaño y forma de nuestro sprite.

![](images/player-scene.png)

> RectangleShape2D nos permite definir al área de colisión de nuestro personaje.

* Grabar la escena que acabamos de crear como `actor/player/player.tscn`.

## Level 1

* Volvemos a la escena `level` que sólo tiene un nodo.
* Al lado del símbolo "+" tenemos la "cadena" (instanciar objeto). La usaremos para añadir la escena `player` como un nodo hijo dentro de `level`.
* En la parte superior de Godot elegimos visión "2D". Podemos mover el `player` para moverlo al centro de la ventana o bien usar las propiedades de la ventana inspector y asignar el valor de posición `Node2D/Transform/Position` con x = 100 e y = 74.
* Seleccionamos el nodo `level`, y en la ventana inspector, buscamos la propiedad `Node2D/Scale`. Ponemos los valores x=4 e y=4. Para hacer un escalado de todos los nodos de la escena. Esto lo hacemos porque tenemos unas imágenes muy pequeñas (8x8) y queremos que se vean un poco más grandes (32x32).
* **Pulsar F5** y vemos nuestro juego con un personaje que no se mueve.

![](images/level1-player.png)

Vamos continuar para darle movimiento al personaje.

[next](02-mover.md)
