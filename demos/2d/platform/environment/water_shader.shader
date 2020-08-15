shader_type canvas_item;
uniform int mode = 3;
uniform float level = 10.0;
uniform float speed = 2;

void vertex() {
	if (mode == 1) {
		// Move up and down
		VERTEX += vec2(0, sin(TIME)*level);
	} else if (mode == 2) {
		// 
		VERTEX += vec2(0, sin(TIME * UV.x)*level);
	} else if (mode == 3) {
		// 
		//VERTEX += vec2(0, sin(UV.x * 2.0 * 3.14)*level);
		VERTEX += vec2(0, sin((UV.x+TIME) * speed) * level );
	}
}