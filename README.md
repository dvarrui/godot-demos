
# Godot

Este repositorio contiene pequeñas demos jugables, creadas con el motor GodotEngine (versión 3.2) y recursos de uso libre.

1. [Arkanoid](#arkanoid)
1. [Command](demos/command) (En construccion!)
1. [Platform](#platform)
1. [Tower Defense](demos/tower-defense): Estado EN CONSTRUCCION.
1. [Roguelike](demos/roguelike): Estado TERMINADO.
    * Ir a [explicación](docs/roguelike/README.md) para ver un pequeño resumen.
1. [SpaceShooter](#spaceshooter)

## [Arkanoid](demos/arkanoid)

* Inspirado en los ejemplos y vídeos de Rafanoid.
* Se usa el motor de física en el movimiento de la pelota, aprovechando que todos los elementos del juego son cuerpos físicos: RigidBody2D(pelota), StaticBody2D(los muros), KinematicBody2D(player).
* Hay una ventana de menú inicial, y una ventana de pausa creadas con los elementos de GUI(Container, Label y Button).
* Futuro: añadir efecto de Particle2D a la pelota, aumentar el número de niveles, diseñar varios muros con diferentes comportamientos (Por ejemplo diferente resistencia).

![](docs/images/arkanoid.png)

## [Platform](demos/platform)

* demos/platform: Juego de plataformas con gráficos de 16x16 y 1bit color, descargados de la página web de Kenney.
* El player es un KinematicBody2D con colisiones con el entorno. Las plataformas móviles también son KinematicBody2D.
* Los enemigos son Area2D.
* Para diseñar el mundo se ha usado TileMap y TileSet para crear un conjunto de celdas (tiles).
* Futuro: De momento sólo tenemos un nivel, pero la idea es crear más pantallas formando un mapa más complejo.

![](docs/images/platform.png)

## [Roguelike](demos/roguelike)

* demos/roguelike: Un juego 2D de vista top-down, donde el player debe coger todas las llaves que abren la puerta para escapar del laberinto mientras esquivamos a los enemigos.
* Se usa el motor de física para controlar la colisiones. El player es un KinematicBody2D y el laberinto.
* Ir a [explicación](docs/roguelike/README.md) para ver un pequeño resumen.

![](docs/images/roguelike.png)

## [SpaceShooter](demos/spaceshooter)

* demos/spaceshooter: Shooter de scroll vertical. Los assets son imágenes de 16x16, hechas con Gimp y luego escaladas a 48x48 para resaltar el efecto de pixelado.
* Todos los objetos del juego son del tipo Area2D. Actualmente están definidos los siguientes elementos: Rocas (pequeñas y grandes), Satélites, Tie-figther y el X-Wing(Player).
* Efectos: tenemos efectos de explosiones creados con Particle2D, además se usa Timer y SelfModulate para el efecto flash cuando se recibe un impacto no letal.
* Hay dos ficheros Singleton: Global y Loader. Global para las variables globales del juego. Loader para contener las funciones de construcción del nivel. El diseño del nivel se hace en un fichero de texto (level/level2.txt) que Loader lee y construye.

![](docs/images/spaceshooter.png)

# Enlaces de interés

* [Tutoriales](docs/tutorials.md)
* [Arte](docs/art.md): Free Assets, Arte vectorial y Pixel art.
* [Miscelanea](docs/misc.md): Shaders y cursos de Godot
