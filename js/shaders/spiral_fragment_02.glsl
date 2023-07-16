
#define PI 3.14159265359
// Uniforms
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
  

void main (){
//normalize the pixel coordinates to -1.0 to 1.0
vec2 st = gl_FragCoord.xy/u_resolution.xy;
st *= 2.0;
st -= 0.5;
//normalize mouse coordinates to -1.0 to 1.0
vec2 mouse = u_mouse.xy/u_resolution.xy;
mouse *= 2.0;


//6 circle in different sizes, one on top of the other
float circle1 = smoothstep(0.5, 0.49, distance(st, vec2(0.5, 0.5)));
float circle2 = smoothstep(0.4, 0.39, distance(st, vec2(0.5, 0.5)));
float circle3 = smoothstep(0.3, 0.29, distance(st, vec2(0.5, 0.5)));
float circle4 = smoothstep(0.2, 0.19, distance(st, vec2(0.5, 0.5)));
float circle5 = smoothstep(0.1, 0.09, distance(st, vec2(0.5, 0.5)));
float circle6 = smoothstep(0.0, 0.01, distance(st, vec2(0.5, 0.5)));

//animate the circles radius from center to edge and back to center




//apply ripple distortion to each circle based on distance from mouse
float ripple1 = 0.1 * sin(distance(st*0.5, vec2(mouse)) * 25.0 - u_time * 1.);
float ripple2 = 0.1 * sin(distance(st, vec2(mouse)) * 50.0 - u_time * 2.);
float ripple3 = 0.1 * sin(distance(st, vec2(mouse)) * 75.0 - u_time * 3.);
float ripple4 = 0.1 * sin(distance(st, vec2(mouse)) * 100.0 - u_time * 4.);
float ripple5 = 0.1 * sin(distance(st, vec2(mouse)) * 125.0 - u_time * 6.);
float ripple6 = 0.1 * sin(distance(st, vec2(mouse)) * 150.0 - u_time * 8.);

//add all the ripples together
vec3 ripples = vec3(ripple1, ripple2, ripple3 + ripple4 + ripple5 + ripple6);

vec3 color = vec3(circle1 *circle2,  circle3- circle4, circle5 * circle6);
//set ripples center to mouse position
//color += vec3(ripple1, ripple2, ripple3 + ripple4 + ripple5 + ripple6) * vec3(mouse, 0.0);

//set ripples as a float
//float ripples = ripple1 + ripple2 + ripple3 + ripple4 + ripple5 + ripple6;
//loop through ripples and add them to the color
for (float i = 1.0; i < 7.0; i++) {
    color += vec3(ripple1, ripple2, ripple3 + ripple4 + ripple5 + ripple6) * vec3(mouse, 0.0);
}


color = step(0.5, color);

    gl_FragColor = vec4(color, 1.0);
}