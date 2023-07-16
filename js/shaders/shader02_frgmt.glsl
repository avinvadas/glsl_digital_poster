#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;




void main(){
   vec2 st = gl_FragCoord.xy/u_resolution.xy;
   
  
   
   st = (st *2.0 -0.5);

 
   //setting center and placement:
 
  float pct = distance(vec2(st.x, st.y),vec2(0.5,0.1));
  

 //setting repetitional pattern:
  float d = 0.0;
  float ripple_size= 0.5;
  float wrap_size = 0.6;
  float ripple_number = 10.0;
  d = length( (pct-fract(u_time*0.01)));
 
 

 
  vec3 color= vec3(step(pct,wrap_size))-vec3(step(ripple_size,  fract(d * ripple_number  )))-
  vec3(smoothstep(0.5, 0.0, pct*1.75));
  
//inverting b/w
  vec3 color_invert = vec3(1.0-color);

//setting final frag shade:
   gl_FragColor = vec4( vec3(color),1.0);
}