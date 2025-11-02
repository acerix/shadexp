shader_type canvas_item;

uniform float viewport_aspect_ratio;
uniform vec2 centre;
uniform float zoom;

void fragment() {
	// calculate coordinates of the point at this pixel
	vec2 point = (UV - vec2(0.5)) * vec2(viewport_aspect_ratio, -1) * zoom * 2.0 + centre;

	// draw unit xy grid -- red: -|x%1|, green: -|y%1|
	float line_width = abs(zoom) / 1024.0;  // SCREEN_PIXEL_SIZE.x
	float r = fract(line_width - abs(point.x));
	float g = fract(line_width - abs(point.y));

	// unit circle around origin -- blue: (xx+yy)%1
	float b = fract(dot(point, point));

	// set pixel colour
	COLOR = vec4(r, g, b, 1.0);
}
