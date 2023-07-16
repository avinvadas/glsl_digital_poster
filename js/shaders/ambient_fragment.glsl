precision highp float;

uniform float u_time;
uniform vec2 u_resolution;

void main() {
  vec2 p = (gl_FragCoord.xy * 2.0 - u_resolution.xy) / min(u_resolution.x, u_resolution.y);

  float r = 0.5 + 0.5 * sin(u_time + p.x * 5.0);
  float g = 0.5 + 0.5 * sin(u_time + p.y * 5.0);
  float b = 0.5 + 0.5 * sin(u_time + (p.x + p.y) * 5.0);

  gl_FragColor = vec4(r, g, b, 1.0);
}
