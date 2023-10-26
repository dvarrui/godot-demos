shader_type canvas_item;

uniform float progress = 1.0;
uniform float shine = 0.5;
uniform float offset = 0.1;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float xy = UV.x + UV.y;

	if ((xy > progress - offset ) && (xy < progress + offset)) {
		color.r += shine;
		color.g += shine;
		color.b += shine;
	}
	COLOR = color;
}
