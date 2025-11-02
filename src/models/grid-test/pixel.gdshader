shader_type canvas_item;

uniform float viewport_aspect_ratio = 1.0;

void fragment() {
	//vec2 uv = (UV - vec2(0.5)) * vec2(viewport_aspect_ratio, 1) / zoom + position;
	vec2 uv = (8.0 * UV - vec2(4)) * vec2(viewport_aspect_ratio, 1);
	float r = fract(-abs(uv.x));
	float g = fract(-abs(uv.y));
	float b = dot(uv, uv) < 1.0 ? 1.0 : 0.0;
	COLOR = vec4(r, g, b, 1.0);
}
