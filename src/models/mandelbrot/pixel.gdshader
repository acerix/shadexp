shader_type canvas_item;

uniform float viewport_aspect_ratio;
uniform vec2 centre;
uniform float zoom;

#include "res://addons/glsl-arbitrary-precision/arbitrary.gdshaderinc"

// from https://github.com/RohanFredriksson/glsl-arbitrary-precision
float mandelbrot() {
    
    uint c_r[ARRAY_SIZE];
    uint c_i[ARRAY_SIZE];
    uint z_r[ARRAY_SIZE];
    uint z_i[ARRAY_SIZE];
    
    load(c_r, -0.75);
    load(c_i, 0.1);
    zero(z_r);
    zero(z_i);
    
    uint nz_r[ARRAY_SIZE];
    uint nz_i[ARRAY_SIZE];
    
    int iterations = 64;
    for (int k = 0; k < iterations; k++) {
        
        uint tmp[ARRAY_SIZE];
        uint radius[ARRAY_SIZE];
        mul(z_r, z_r, tmp);
        mul(z_i, z_i, radius);
        add(radius, tmp, radius);
        
        if (radius[1] > 4) {
            return float(k) / float(iterations);
        }
        
        mul(z_i, z_i, nz_r);
        negate(nz_r);
        mul(z_r, z_r, tmp);
        add(nz_r, tmp, nz_r);
        add(nz_r, c_r, nz_r);
        
        load(nz_i, 2.0);
        mul(nz_i, z_r, nz_i);
        mul(nz_i, z_i, nz_i);
        add(nz_i, c_i, nz_i);
        
        assign(z_r, nz_r);
        assign(z_i, nz_i);
        
    }
    
    return 0.0;
}

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
