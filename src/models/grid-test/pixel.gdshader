shader_type canvas_item;

uniform float viewport_aspect_ratio = 1;
uniform vec2 centre = vec2(0, 0);
uniform float zoom = 2;
const float grid_width = 0.001;

void fragment() {
	vec2 uv = (UV - vec2(0.5)) * vec2(viewport_aspect_ratio, -1) * zoom + centre;

	// square grid
	vec2 grid = vec2(grid_width, grid_width) * vec2(1, viewport_aspect_ratio) * abs(zoom);

	// unit square grid -- red: -|x%1|, green: -|y%1|
	float r = fract(grid.x-abs(uv.x));
	float g = fract(grid.y-abs(uv.y));

	// unit circle around origin -- blue: inside
	float b = dot(uv, uv) > 1.0 ? 0.0 : 1.0;

	COLOR = vec4(r, g, b, 1.0);
}
