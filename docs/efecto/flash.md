[<< back](README.md)

# Efecto white flash

1. Crear un shader
2. Componente reutilizable
3. Hide flash

# 1. Crear un shader para hacer el efecto "white flash"

> Enlace de interés:
> * [Create a Flash Shader in Godot 3.2](https://youtu.be/dqilJirAAT0)

vamos a ver la forma de hacer el efecto "white flash" usando shaders en los materiales.
En el ejemplo del vídeo tendremos la siguiente estructura:

```
Character (Node2D)
├── Torso (Sprite)
│   ├── LeftLeg (Sprite)
│   ├── RightLeg (Sprite)
│   ├── Head( Sprite)
│   ├── LeftArm (Sprite)
│   └── RightArm (Sprite)
└── AnimationPLayer
```

* Ir al nodo raíz es del tipo Node2D y vemos que tiene la propiedad `CanvasItem -> Material -> Material` con el valor `Empty`. Añadimos material de tipo `ShaderMaterial`.
* Ir al nodo tipo Sprite `Torso`. Modificar el valor de la propiedad `CanvasItem -> Material -> Use Parent Material` a `On`.
* Editar `Shader Material -> Shader` y creamos un shader nuevo. Lo editamos escribimos el siguiente código shader.

```
shader_type canvas_item;

uniform vec4 flash_color : hint_color = vec4(1.0);
uniform float flash_modifier : hint_range(0.0, 1.0) = 0.0;

void fragment() {
  vec4 color = texture(TEXTURE, UV);
  color.rgb = mix(color.rgb, flash_color.rgb, flash_modifier);
  COLOR = color;
}
```
* Modificar el valor de `Shader Material -> Resource -> Resource -> Local to Scene` a `On`.
* Para probar lo que hemos creado, vamos a `ShaderMaterial` y en el inspector modificamos el valor de las siguientes propiedades para ver los efectos que producen:
    * `Shader Param -> Flash Color` => color blanco.
    * `Shader Param -> Flash Modifier` => 1. Cambiando este valor podemos hacer que la imagen tome el color de flash en mayor o menor medida.    

# 2. Componente reutilizable

En el apartado anterior vimos como hacer un shader que se puede usar para producir el efecto de "white flash". Pero para darle uso, en cada sprite del juego habría que hacer lo siguiente:
* Crear un material del tipo ShaderMaterial.
* Cargar el código del shader dentro del ShaderMaterial.
* Modificar la propiedad `flash_modifier` al valor 1.0.
* Dejar pasar un tiempo y vovler a poner el valor de la propiedad `flash_modifier` a 0.0.

Vamos a tratar de simplificar este proceso creando un componente que podamos reutilizar de forma más cómoda.

* Empezaremos grabando el código del shader anterior en un fichero llamado `white_flash.shader`. Vamos a utilizar este fichero para cargar la información dinámicamente en tiempo de ejecución.
* Creamos una escena llamada `white_flash.tscn` con un nodo raíz **Timer**.
* Al nodo raíz le añadimos el siguiente GDScript:

```
extends Timer

var sprite = null
var shader_res = null
export var duration = 0.05

func _ready():
	shader_res = preload("res://world/effect/white_flash.shader")
	sprite = get_parent()
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = shader_res

func activate():
	sprite.material.set_shader_param("flash_modifier", 1.0)
	start(duration)

func _on_white_flash_timeout():
	sprite.material.set_shader_param("flash_modifier", 0.0)
	stop()
```

* En este momento tendremos en la carpeta `res://world/effect` los ficheros: `white_flash.gd`, `white_flash.shader` y `white_flash.tscn`.
* El código del GDScript de la escena, busca el nodo padre (`sprite`), le crea un `ShaderMaterial`, y dentro del material carga el shader que teníamos creado en un fichero externo. Ya lo tenemos todo preparado.
* Cuando se invoque la función `activate()`, se activa el efecto del shader y el temporizador del Timer se pone a `duration`.
* Cuando el tiempo del temporizador finaliza, se dispara la función `_on_white_flash_timeout()` que restablece el valor del shader que deja la imagen a su forma original.

# 3. Hide flash

Usando la propiedad `Modulate` podemos hacer un efecto flash de parpadeo, pero no podemos generar un flash blanco.

* Creamos una escena llamada `hide_flash.tscn` con un nodo raíz **Timer**.
* Al nodo raíz le añadimos el siguiente GDScript:

```
extends Timer

var sprite = null
export var duration = 0.15

func _ready():
	sprite = get_parent()

func activate():
	sprite.self_modulate = Color(0.5, 0.5, 0.5, 1)
	start(duration)

func _on_hide_flash_timeout():
	sprite.self_modulate = Color(1, 1, 1, 1)
	stop()
```

* El código del GDScript de la escena, busca el nodo padre (`sprite`) y lo guarda en una variable.
* Cuando se invoque la función `activate()`, se activa se cambia el valor de la propiedad `Modulate` del Sprite, y el temporizador del Timer se pone a `duration`.
* Cuando el tiempo del temporizador finaliza, se dispara la función `_on_hide_flash_timeout()` que restablece el valor del Sprite que deja la imagen a su forma original.
