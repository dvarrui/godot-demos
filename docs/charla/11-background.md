
# Background

Los sprites son imágenes 2D que se pueden animar.

## Nuevo proyecto

Vamos a crear nuestro primer proyecto:
* Ejecutamos Godot.
* Pulsamos en `Nuevo proyecto`.
* Completar:
    * Nombre del proyecto: `sprites`
    * Ruta del proyecto: `learn-godot/proy/sprites`
* Pulsar `Crear carpeta`.
* Pulsar `Crear y editar`. Se nos abre el editor de Godot con nuestro nuevo proyecto `sprites` vacío.

## Entorno

El entorno tiene las siguientes partes:
* Un **menú** en la barra superior.
* Una ventana central o de trabajo, donde vemos nuestro proyecto vacío. Esta ventana tiene las siguientes opciones: `2D`, `3D`, `Script` y `AssetLib`. Marcamos la opción **2D**. Puesto que vamos a empezar con programas 2D.
* En la zona izquierda tenemos la pestaña `Escenas` y `Sistemas de Archivos`.
* En la zona derecha tenemos la pestaña `Inspector`.

> Comentar qué son las escenas y nodos

## Sprites

> Comentar las diferencias 2D vs 3D

* Ir a la pestaña `Escenas -> Crear nodo raíz -> Escena 2D`. Se nos crea un nodo tipo `Node2D`.
* Añadir nodo hijo (`+`) tipo `Sprite`. Todavía no se ve nada porque hay que elegir una textura (imagen).

> La imágenes que voy a usar tienen licencias que nos permiten su uso y se han descargado de sitios como OpenGameArt.

* Descargo una imagen y la grabo en `learn-godot/proy/sprites/city.png`. También pongo la licencia de la imagen `License.txt`.
* Vuelvo al editor -> Elijo en nodo `Sprite`.
* En el inspector voy a `Texture -> Cargar -> city.png`. Ahora el nodo sprite muestra una imagen de fondo.
* Pulsamos `F6` para ver nuestra escena.
* Grabar escena como `background.tscn`.
