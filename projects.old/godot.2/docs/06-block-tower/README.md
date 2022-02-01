
#Proyecto `block-tower`

Este es un juego 2D, con física, donde la mecánica del juego consiste en
soltar bloques para formar una torre.

Esquema de trabajo:
1. Idea
2. Assets
3. Crear personajes: blocks y platforms
4. Lo unimos todos
5. Volver al paso 1

#1. La idea

Vamos a crear un minijuego 2D, con física.
La mecánica del juego consiste en soltar bloques para formar una torre.

* Creamos directorio para el proyecto llamado `06-block-tower`.
* Creamos un nuevo proyecto Godot `Programa Godot -> New Project -> game-06-block-tower`.
* Editamos el proyecto para comenzar a crear el juego.

#2. Assets

Descargamos unos `assets` para empezar:
* Los sonidos se han descargado de [FreeSound](https://www.freesound.org)
   * Convertimos el fichero en formato WAV de 16 bits.
* Los iconos se han descargado de [www.game-icons.net](www.game-icons.net)
* Los gráficos son iconos descargados de la web anterior y los modificamos
para que tengan el tamaño de 64x64.
    * En el directorio `blocks` ponemos imágenes de una caja y una bola.
    * En el directorio `platforms` ponemos imágenes de un ladrillo.
    * En el directorio `hand` ponemos imagen de una mano.
* Decargamos un fondo de `OpenGameArt` y lo guardamos en `levels/bakground1.png`

#3. Creando las partes

##3.1. Bloque cuadrado (Square)

Vamos a crear un bloque de forma cuadrada que caerá sólo por efecto de la física.

Creamos una **escena** para contener a `square` con la siguiente estructura de nodos.
* Como nodo principal/raíz `square`de tipo `RigidBody2D`, puesto que queremos
que este objeto esté regulado por el motor de física.
* Creamos subnodos hijos:
    * `sprite` nodo de tipo `Sprite`
        * Atributo texture = imagen `blocks/wooden-crate.png`
    * `shape` nodo de tipo `CollisionShape2D` -> Rectangular.
* Guardamos la escena `square` como `res://blocks/square.xml`

##3.2. Plataforma (platform)

Vamos a crear un bloque de forma cuadrada que caerá sólo por efecto de la física.

Creamos una **escena** para contener a `platform1` con la siguiente estructura de nodos.
* Como nodo principal/raíz `platform1`de tipo `StaticBody2D`, puesto que queremos
que este objeto con física estática. Esto es que no se mueva pero que afecte a las
colisiones del resot de los objetos.
* Creamos subnodos hijos:
    * `sprite` nodo de tipo `Sprite`
        * Atributo texture = imagen `platforms/brick-wall.png`
    * `shape` nodo de tipo `CollisionShape2D` -> Rectangular.
* Guardamos la escena `square` como `res://platforms/platform1.xml`

##3.3 La mano (hand)

El jugador mueve la mano y al pulsar el botón se deja caer un bloque.
Vamos a crear la mano.

Creamos una **escena** para contener a `hand` con la siguiente estructura de nodos.
* Como nodo principal/raíz `hand`de tipo `Node2D`.
* Dentro creamos un nodo hijo `sprite` de tipo `Sprite`.
    * En el atributo textura asociamos el fichero de la imagen.
* Guardamos la escena `hand` como `res://hand/hand.xml`

Para darle comportamiento a `hand`, vamos a crear un **script** en el nodo raíz.
* Seleccionamos nodo raíz, botón derecho, agragar script.
* Consultar script [hand.gd](./../../games/06-block-tower/hand/hand.gd).

#4. Lo unimos todo

Vamos a crear un nivel con plataformas y añadiremos la mano.

Creamos una **escena** para `level1`:
* Como nodo principal/raíz `level1`de tipo `Node2D`.
* Creamos subnodos hijos:
    * Dentro creamos un nodo hijo `sprite` de tipo `Sprite`.
        * En el atributo textura asociamos el fichero de la imagen.
    * Instanciamos la mano.
* Guardamos la escena `level1` como `res://levels/level1.xml`

Ponemos esta escena como la principal del proyecto en:
* `Configuración de proyecto -> Application -> Main Scene -> res://level1/level1.xml`

# ¿Cómo crear un nuevo nivel?

* Escena -> nueva escena
* Crear nuevo nodo de tipo `Node2D`, y le ponemos el nombre `level2`.
* Creamos subnodos hijos:
    * Dentro creamos un nodo hijo de tipo `Sprite` con el nombre `sprite` .
        * En el atributo textura asociamos el fichero de la imagen.
    * Instanciamos la mano.
* Guardamos la escena `level1` como `res://levels/level2.xml`

Ponemos esta escena como la principal del proyecto en:
* `Configuración de proyecto -> Application -> Main Scene -> res://level1/level1.xml`
