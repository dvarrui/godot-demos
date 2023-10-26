shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float desp = 0.5;
	if (UV.x > 0.5) {
		color.g += desp;
		if (UV.y > 0.5) {
			color.r += desp;
		}
	} else {
		if (UV.y < 0.5) {
			color.r += desp;
		}
		if (UV.y > 0.5) {
			color.b += desp;
		}
	}
	// Place fragment code here.
	COLOR = color;
}
