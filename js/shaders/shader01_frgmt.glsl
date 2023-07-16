#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265359;
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float u_grid_column_width;
uniform vec3 u_color_primary;
uniform float u_shader_speed;



float plot(vec2 st, float pct, float volume){
  return  smoothstep( pct-volume, pct, 0.25) -
          smoothstep( pct, pct+volume, 0.25);
}


void main() {

    vec2 st = gl_FragCoord.xy/u_resolution;
    vec2 mouse = u_mouse/u_resolution;
    float shader_speed = u_shader_speed *0.1;
    float column_width = u_grid_column_width;
    //convert hexdecimal to hsl:

    // draw a circle
    float d = distance((0.5-mouse)/st,vec2(0.5));
    // Smooth interpolation between 0.1 and 0.9
    float y = smoothstep(0.2,0.8,st.x);
    vec3 color = vec3(0.);
    float volume = 0.5 + 
    (atan((st.x))* cos(u_time *.0025)+0.025)*
     atan(st.y)* 4.0
     +u_time* shader_speed;
    float waveA = sin(volume+10.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+10.)*0.0075;
  if(u_resolution.x <= u_resolution.y){
  //divide canvas to 4 columns and distort waveA around them
    if(st.x < column_width){
        waveA = sin(volume+10.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+10.)*0.0075;
    }else if(st.x < (column_width * 2.)){
        waveA = sin(volume+12.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+10.)*0.0075;
    }else if(st.x < (column_width * 3.)){
        waveA = sin(volume+8.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+10.)*0.0075;
    }else{
        waveA = sin(volume+16.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+10.)*0.0075;
    }
  }else{
    st.x *= u_resolution.x/u_resolution.y;
    if(st.x < (column_width )){
        waveA = sin(volume+2.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+2.)*0.0075;
    }else if(st.x < (column_width * 2.)){
        waveA = sin(volume+12.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+2.)*0.0075;
    }else if(st.x < (column_width * 3.)){
        waveA = sin(volume+8.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+2.)*0.0075;
    }else  if(st.x < (column_width *4.)){
        waveA = sin(volume+16.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+2.)*0.0075;
    }else  if(st.x < (column_width *5.)){
        waveA = sin(volume+24.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+2.)*0.0075;
   
     }else{
      waveA = sin(volume+32.)*(mouse.x/mouse.y/0.5)*2.95/ cos(volume+2.)*0.0075;
   
    }
    //set a debugging script that sends all the values to the console
    

  }
    //draw wave



    float pctG =  (plot(st,d,waveA))-0.75;

    color =    vec3(pctG * (1.0 / u_color_primary.r),
                    pctG * (1.0/ u_color_primary.g), 
                    pctG * (1.0/ u_color_primary.b)  );

    gl_FragColor = vec4(color,1.0);
}