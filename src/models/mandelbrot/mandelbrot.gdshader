shader_type canvas_item;

uniform float viewport_aspect_ratio;
uniform vec2 centre;
uniform float zoom;

#include "res://addons/glsl-arbitrary-precision/arbitrary.gdshaderinc"

const int max_iterations = 64;

// from https://github.com/RohanFredriksson/glsl-arbitrary-precision
int mandelbrot(vec2 c) {
	
	// c = (real + img)
    uint c_r[ARRAY_SIZE];
    uint c_i[ARRAY_SIZE];
	load(c_r, -c.y);
	load(c_i, c.x);
	
	// z = 0
    uint z_r[ARRAY_SIZE];
    uint z_i[ARRAY_SIZE];
    zero(z_r);
    zero(z_i);
	
	// z² = 0
    uint zz_r[ARRAY_SIZE];
    uint zz_i[ARRAY_SIZE];
    zero(zz_r);
    zero(zz_i);

	// loop until escape or iteration limit
	int i = 0;
    while (i++ < max_iterations) {
        
		// point escapes when outside circle of radius 2
		//if (z2.x + z2.y > 4.0) {
			//return i;
		//}
		
    	// z ↦ z²+c
        //z = vec2(
            //2.0 * z.y * z.x - c.x,
            //z2.y - z2.x - c.y
        //);
		
			
			
		// zz = z * z;
		
		
        uint tmp[ARRAY_SIZE];
        uint radius[ARRAY_SIZE];
        mul(z_r, z_r, tmp);
        mul(z_i, z_i, radius);
        add(radius, tmp, radius);
        
        if (radius[1] > 4u) {
            return i;
        }
        
        mul(z_i, z_i, zz_r);
        negate(zz_r);
        mul(z_r, z_r, tmp);
        add(zz_r, tmp, zz_r);
        add(zz_r, c_r, zz_r);
        
        load(zz_i, 2.0);
        mul(zz_i, z_r, zz_i);
        mul(zz_i, z_i, zz_i);
        add(zz_i, c_i, zz_i);
        
        assign(z_r, zz_r);
        assign(z_i, zz_i);
		
		
    }
    return i;
}

//int mandelbrot(vec2 c) {
        //vec2 z = vec2(0, 0);
        //vec2 z2 = vec2(0, 0);
//
	    //// z ↦ z²+c
		//int i = 0;
	    //while (i++ < max_iterations) {
	        //z = vec2(
	                //2.0 * z.y * z.x - c.x,
	                //z2.y - z2.x - c.y
	        //);
	        //z2 = z * z;
	    //}
	    //return i;
//}

void fragment() {
	// calculate coordinates of the point at this pixel
	vec2 point = (UV - vec2(0.5)) * vec2(viewport_aspect_ratio, -1) * zoom + centre;

	// mandelbrot set, colourizing iterations of escape
    int z = mandelbrot(point);
	
	float r = z == max_iterations ? 0.0 : 0.5;
	float g = float(4 * z / max_iterations);
	float b = 0.5;
	
	//int poo = int(TIME * 10.0) % max_iterations;
	//g = b = r = z == poo ? 0.0 : 1.0;
	
	COLOR = vec4(r, g, b, 1.0);

	// grid
	//float line_width = abs(zoom) / 1024.0;
	//float r = fract(line_width - abs(point.x));
	//float g = fract(line_width - abs(point.y));
	//float b = fract(dot(point, point));
	//COLOR = vec4(r, g, b, 1.0);
}
