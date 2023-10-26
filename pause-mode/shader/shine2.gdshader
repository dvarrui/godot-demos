shader_type canvas_item;

uniform float shine = 0.5;
uniform float offset = 0.1;

void fragment() {
float progress = 1.0;
	vec4 color = texture(TEXTURE, UV);
	float xy = UV.x + UV.y;
	progress = (sin(TIME * 2.0)) * 3.0;
	if ((xy > progress - offset ) && (xy < progress + offset)) {
		color.r += shine;
		color.g += shine;
		color.b += shine;
	}
	// if (progress > 6.0) { progress = 0.0; }
	COLOR = color;
}
