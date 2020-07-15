
# Godot

En este repositorio contiene pequeñas demos jugables, creadas con el motor GodotEngine (versión 3.2) y otros recursos libres.

1. [Arkanoid](demos/arkanoid): Estado TERMINADO.
    * Inspirado en los ejemplos y vídeos de Rafanoid.
1. [Command](demos/command) (En construccion!)
1. [Platform](demos/platform): Tenemos un player con sus mecánicas de movimiento y salto. Hay un sólo un nivel en construcción.
1. [Tower Defense](demos/tower-defense): Estado EN CONSTRUCCION.
1. [Roguelike](demos/roguelike): Estado TERMINADO.
    * Ir a [explicación](docs/roguelike/README.md) para ver un pequeño resumen.
1. [SpaceShooter](demos/spaceshooter): Estado EN CONTRUCCION. Tenemos la mecánica del player de movimiento y disparo.
Falta crear las mecánicas de los enemigos y crear algún nivel.

---
## Más información

### Tutoriales sobre Godot Engine

* [Aprende sobre Godot Engine 3.1 - Curso en Español](https://www.reddit.com/r/godot/comments/aod5je/aprende_sobre_godot_engine_31_curso_en_espa%C3%B1ol/?utm_medium=android_app&utm_source=share)
* [Kids can code - Godot Recipes](http://kidscancode.org/godot_recipes/)
* [Awesome Godot](https://github.com/Calinou/awesome-godot/blob/master/README.md)
* Video: [Very simple game using Godot Engine](http://youtu.be/svoTd2gDdt4)
* [Procedural levels](https://twitter.com/NathanGDQuest/status/1249757240774492160?s=09)
* [Godot Signals and How to Use Them - GoTut: Game and Other Tutorials](https://www.gotut.net/godot-signals/)
* [Game Clone Challenges](https://github.com/rby90/game-clone-challenges): A progressive list of game clones for the practicing programmer.
* [Transiciones con Nodo Tween Godot - Avance 3 del Curso completo](https://youtu.be/dbw8pEnJChQ)
* [Make your first 3D game from scratch in Godot Engine!](https://youtu.be/fdMOHMYslOY)
* [Particles 2D en Godot - Avance 1 del Curso completo by Rafanoid](https://youtu.be/sQ_NhtFkv4M)
* [01 - Sistemas de partículas - Explosión (2D) - Godot 3](https://youtu.be/gkzWruANadI)
* [Godot Tutorials - List of Video and Written Tutorials - godot](https://www.reddit.com/r/godot/comments/an0iq5/godot_tutorials_list_of_video_and_written/)


### Free Assets

* [Game-Icons.net](https://game-icons.net/)
* [Godot crt-lottes shader: port of the libretro crt-lottes GLSL shader to Godot shading language.](https://github.com/qarlosh/godot-crt-lottes-shader/blob/master/README.md)
* [Kenney](https://www.kenney.nl/)
* spriter-resource
* [Transitions Between Scenes - Godot Asset by César León](https://in3mo.itch.io/transitions-godot)
* [GDQuest/godot-visual-effects](https://github.com/GDQuest/godot-visual-effects): Open-source visual effects designed in Godot, from our VFX Secrets course. - GDQuest/godot-visual-effects
* [Clasic Sonic palette Shader](https://github.com/raphaklaus/sonic-palette-fade/blob/master/README.md)
* Libro sobre AI en videojuegos: http://gameaibook.org/

### Arte vectorial

* [Learn 2D gameart using vector tools - 2dgameartguru](https://2dgameartguru.com/)
* Pixel Art [Crear y animar un sprite](http://www.pixelsmil.com/2012/04/crear-y-animar-un-sprite-tutorial-paso.html?m=1)
* [2D Game Art Tutorials by Chris Hildenbrand](https://2d-game-art-tutorials.zeef.com/chris.hildenbrand)

## Shaders

* Shader de ejemplo
```
shader_type canvas_item;
uniform sampler2D gradient: hint_black;
uniform float mix_amount = 1.0;

void fragment() {
  vec4 input_color = texture(TEXTURE, UV);
  float grayscale_value = dot(input_color.rgb, vec3(0.299, 0.587, 0.114));
  vec3 sampled_color = texture(gradient, vec2(grayscale_value, 0.0)).rgb;

  COLOR.rgb = mix(input_color.rgb, sampled_color, mix_amount);
  COLOR.a = input_color.a;
}
```
* Shader [grayscale-shader-godot-3](https://github.com/hamdle/grayscale-shader-godot-3/blob/master/Node.tscn)

### Cursos

* [Arkanoid by rafanoid](https://www.udemy.com/course/godot-3-primer-videojuego/learn/lecture/19641354#content)
* Video [GDC - Math for Game Programmers - YouTube](https://www.youtube.com/playlist?list=PLVmb_qp6XRcwzN9l5mcia6Gh3HOgut3bH)
* [PRÓXIMOS WEBINARS Y MASTER CLASES ONLINE GRATIS](https://www.game-levelup.com/webinars)
