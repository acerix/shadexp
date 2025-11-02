shader_type canvas_item;

uniform float viewport_aspect_ratio = 1.0;

void fragment() {
	vec2 uv = (8.0 * UV - vec2(4)) * vec2(viewport_aspect_ratio, 1);

	// unit square grid -- red: -|x%1|, green: -|y%1|
	float r = fract(0.01-abs(uv.x));
	float g = fract(0.01-abs(uv.y));

	// unit circle around origin -- blue: inside
	float b = dot(uv, uv) > 1.0 ? 0.0 : 1.0;

	COLOR = vec4(r, g, b, 1.0);
}
