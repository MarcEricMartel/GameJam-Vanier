shader_type canvas_item;

uniform float fill;

void fragment() {
	if ((fill + 0.5) * 0.5 >= 1.0 - UV.y)
		COLOR = vec4(1, 1, 0.1, texture(TEXTURE, UV).a);
	else COLOR = texture(TEXTURE, UV);
}
