
# Efecto flash

El efecto flash es hacer que la imagen parpadee o emita un destello.

# Efecto white flash con shaders

> Enlace de interés:
> * [Create a Flash Shader in Godot 3.2](https://youtu.be/dqilJirAAT0)

Usando la propiedad `Modulate` podemos hacer un efecto flash de parpadeo, pero no podemos generar un flash blanco, así que en este tutoríal vamos a ver una forma de hacer el efecto "white flash" usando shaders en los materiales.

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
* Editar `Shader Material -> Shader` y creamos un shader nuevo. Lo editamos y se nos abre una ventana para escribir el código del shader.

```
shader_type canvas_item;

uniform vec4 flash_color : hint_color = vec4(1.0)
uniform float flash_modifier : hint_range(0.0, 1.0) = 0.0;

void fragment() {
  vec4 color = texture(TEXTURE, UV);
  color.rgb = mix(color.rgb, flah_clor.rgb, flahs_modifier);
  COLOR = color;
}
```
* Modificar el valor de `Shader Material -> Resource -> Resource -> Local to Scene` a `On`.
* Editamos `ShaderMaterial` en el inspector y vemos las siguientes propiedades:
    * `Shader Param -> Flash Color` = color blanco.
    * `Shader Param -> Flash Mo..` = 1. Cambiando este valor la imagen toma el color anterior en mayor o menor medida.    
