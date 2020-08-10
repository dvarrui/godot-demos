 [<< back](../README.md)

# GDScript

> Enlace de interés:
> * [Tutorial de GDScript para programadores - Parte 4] (https://youtu.be/DG9F7PmbrTc)
> * Hacer pruebas online con GDScript (https://gd.tumeo.space/)

## Herencia

En GDScript un archivo representa una clase. Cuando creamos código GDScript asociado a un nodo del tipo KinematicBody2D, y tenemos algo como lo siguiente, quiere decir que nuestro nodo es un objeto que hereda de KinematicBody2D.

```
extends KinematicBody2D

func _ready():
  pass
```

La función `_ready()` se ejecuta cuando el nodo está cargado en la escena del juego. Se puede usar para inicializar atributos del objeto.

## Constructor

Si por ejemplo tenemos el siguiente código:

* Fichero `perro.gd`:

```
extends Node2D
class_name Perro

func _init():
  print("Estamos en el constructor del objeto Perro")
```

* Fichero `main.gd`:

```
extends Node2D

func _ready():
  var p = Perro.new()
```

Cuando se ejecuta `main.gd`, vemos en la salida el mensaje "Estamos en el constructor del objeto Perro".

## Clases internas

También podemos definir clases dentro de otra clase (usando `class`) y usar el operador `is` para comprobar si un objeto hereda de una clase determinada. Veamos el ejemplo:

```
extends Node

class Gato:
  func _init():
    print("[gato] Miau")

func _ready():
  var g = Gato.new()
  if g is Gato:
    print("Tenemos un gato")
```

Como salida tendremos:

```
[gato] Miau
Tenemos un gato
```

## Herencia en las clases internas

En este ejemplo vemos que las clases internas pueden heredar de otras clases internas, y que el operador `is` nos permite detectar si un objeto hereda de una clase determinada.

```
extends Node

class Animal:
  func info():
    print("[animal] Soy un animal")

class Gato:
  extends Animal
  func _init():
    print("[gato] Miau")

func _ready():
  var g = Gato.new()
  if g is Animal:
    print("Tenemos un animal")
    g.info()
```

Como salida tendremos:

```
[gato] Miau
Tenemos un animal
[animal] Soy un animal
```
