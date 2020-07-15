[<< back](../README.md)

# Shaders

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

# Cursos

* [Arkanoid by rafanoid](https://www.udemy.com/course/godot-3-primer-videojuego/learn/lecture/19641354#content)
* Video [GDC - Math for Game Programmers - YouTube](https://www.youtube.com/playlist?list=PLVmb_qp6XRcwzN9l5mcia6Gh3HOgut3bH)
* [PRÓXIMOS WEBINARS Y MASTER CLASES ONLINE GRATIS](https://www.game-levelup.com/webinars)
