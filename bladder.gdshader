shader_type canvas_item;

uniform vec4 tex;
uniform float fill;

void fragment() {

	if ((fill + 0.5) * 0.5 >= 1.0 - UV.y)
		COLOR = vec4(0.1, 0.4, 0.4, 1.0);
	
	COLOR.a = tex.a;
}

