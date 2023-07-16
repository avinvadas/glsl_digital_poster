#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_random;

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution.xy;

  // Set the background to black
  vec3 color = vec3(0.0);

  // Calculate a random x position for each raindrop
  float x = u_random.x;

  // Set the y position of the raindrop based on time
  float y = mod(gl_FragCoord.y + u_time * 100.0, u_resolution.y);

  // Calculate the distance of the current pixel to the nearest raindrop
  float d = length(vec2(st.x - x, st.y - y));

  // Draw a 2px-wide white raindrop if the current pixel is close enough to a raindrop
  if (d < 0.02) {
    color = vec3(1.0);
  }

  gl_FragColor = vec4(color, 1.0);
}
