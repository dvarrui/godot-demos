

# Proyecto 01-shooter

Empezamos nuestros tutoriales con un shooter 2D, porque parece un juego sencillo para empezar.

# Créditos

* Basado en un idea original de Juan Linietsky:
    * [Proyecto Github](https://github.com/reduz/godot_workshop)
    * [Vídeo de Youtube en español](https://www.youtube.com/watch?v=XEkePR_3BU8)
    * [English Youtube video](https://www.youtube.com/watch?v=9GPIeeJXBLc)   

Otros enlaces de interés
* [starwars](https://github.com/TutorialDoctor/TD-Godot-Games/tree/master/starwars)

Esquema de trabajo:
1. Idea
2. Assets
3. Crear personajes: player, enemy, asteroid
4. Lo unimos todos
5. Volver al paso 1

#1. La idea

Vamos a crear un minijuego de marcianitos 2D.

* Creamos directorio para el proyecto llamado `01-shooter`.
* Creamos un nuevo proyecto Godot `Programa Godot -> New Project`.
* Editamos el proyecto para comenzar a crear el juego.

![project-manager](./images/project-manager.png)

#2. Assets

Descargamos unos `assets` para empezar:
* Los gráficos los descargamos de `https://github/reduz/godot_workshop`.
* Los sonidos se han descargado de [FreeSound](https://www.freesound.org)
   * Convertimos el fichero en formato WAV de 16 bits.
* Los iconos se han descargado de [www.game-icons.net](www.game-icons.net)

#3. Creando los personajes

##3.1 Player character

Vamos a crear el personaje del jugador, que es nuestra nave espacial.

**Acciones**

* Creamos las **aciones**(InputMaps) en `Scene -> Project Settings -> InputMaps`
    * Las acciones de nuestro `player` en el juego serán: `left`, `right`, `up`, `down` and `shot`.
    * Asociamos cada acción con entradas de teclado/joystick.

![scene-project-settings-inputmaps](./images/scene-project-settings-inputmaps.png)

* Creamos una **escena** para contener a `player` con la siguiente estructura de nodos.

![player-nodes](./images/player-nodes.png)

**Nodo raíz**

* Como nodo principal/raíz `player`de tipo `Area2D`.
* Dentro creamos un nodo hijo `sprite`de tipo `Sprite`.
    * En el atributo textura asociamos el fichero de la imagen.
* Nodo hijo `shape`de tipo `CollisionPolygon2D`.
    * Creamos una forma poligonal de colisión.
* Guardamos la escena `player` como `res://player/player.xml`

* Explosión (`/explosion`)
    * Dentro de player añadir nodo `Particle2D`.
    * Texture poner la imagen.
    * Spread 180
    * Linear velocity 100
    * Lifetime 1
    * Explosiven 0.2
    * Timeout 0.5
* Sonido (`sample`)
    * Guardamos el fichero de sonido en la carpeta `player` del proyecto.
    * Añadimos nodo `SamplePlayer` y lo llamamos `sample`
    * Vamos a `Config -> Sample -> New SampleLibrary`
    * Añadimos en audio conel nombre `explosion`.
    * Incorporamos código en GDScript para activar (play) el sonido cuando
    explote el jugador.

**Scripting**

* Para darle un comportamiento a `player`, creamos un **script** en el nodo raíz.
    * Este script nos permitirá controlar la nave.
    * En función de las entradas teclado/joystick se producirán unos movimientos u otros de la nave.
    * Consultar script [player.gd](./../../games/01-shooter/player/player.gd).

##3.2 Enemy character

* Creamos una nueva **escena** para `enemy`, la guardamos como `res://enemy/enemy.xml`

* Creamos un nodo raíz `enemy` de tipo `Area2D`.
* Añadimos nodo hijo `anim` de tipo `AnimatedSprite`.
    * En `frames` añadimos las imágenes que forman parte de la animación.
* Añadimos nodo `anim` de tipo `AnimationPlayer`. Sirve para dar animación cambiando la imagen todo el rato.
    * Nueva
    * Lápiz -> Keys
    * activar Autoplay
* Añadimos un nodo hijo `shape` de tipo `CollisionShape2D`
    * Shape de tipo circle2D.
* Anadimos compartamiento al enemigo con un script.
    * El enemigo al recibir un disparo (colisionar con la bala) debe desaparecer.
    [Ver enemy.gd](../../games/01-shooter/enemy/enemy.gd).
* Señales: Crear señal desde `Area2D`
    * Enemy area -> Script

##3.3 Disparo

Vamos a crear una nueva escena para que sea el disparo del player.

* Creamos nueva escena `shot`y la guardamos en `res:/player/shot.xml`
* Creamos nodo raíz `shot` de tipo `Area2D`.
* Añadimos nodo hijo `sprite` de tipo `Sprite`.
* Añadimos nodo hijo `shape` de tipo `CollisionPoligon2D`.
* Le creamos un script al `shot` para programarle un comportamiento.
    * El comportamiento del disparo será que en cuanto se cree, debe
    desplazarse hacia la la parte superior de la pantalla.
    [Ver shot.gd](../../games/01-shooter/player/shot.gd).
    * En disparo se autodestruye cuando sale de la pantalla.
* Añadimos nodo hijo `VisibilityNotifier2D`
    * Lo conectamos a  `exit_screen` del script de `shot`.
    * En el código liberamos el recurso (`queue_free`).

#4. Lo unimos todo

Creamos un nivel para usar los personajes creados anteriormente.

* Creamos una escena nueva `level1` y la guardamos en `res://level/level1.xml`
* Creamos nodo raíz `level1` de tipo `Node2D`.
* Instanciamos los objetos que hemos creado: `player` y `enemy`.
* Los enemigos se pueden instanciar/copiar muchas veces para tener más.
* Creamos un `Node2D` llamado `enemies` y ponemos como hijos de este ( acción `reparent`)
a todos los nodos `enemy`. Esto lo hacemos para poder manejar a todos los
enemigos como un ejército.
* Para animar a todo el ejército añadimos nodo `AnimationPlayer` llamada `move_enemies`.
    * Creamos animación llamada `move_down`.
    * Elegimos nodo `enemies` y añadimos un nuevo key en pos=0.
    * Ponemos de tiempo 10 segundos para la animación.
    * En el segundo 10, movemos el ejército y creamos un segundo key final.


#TODO

* Poner sonido en las explosiones, y en los disparos.
* Hacer que los marcianos exploten.
* Sumar puntos con cada marciano muerto.
* Cerrar la ventana del juego al terminar.
