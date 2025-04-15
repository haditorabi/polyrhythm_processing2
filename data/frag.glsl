#ifdef GL_ES
precision highp float;
precision mediump int;
#endif

uniform float WIDTH;
uniform float HEIGHT;
uniform vec3 metaballs[88];
uniform vec3 metaballColors[88];

uniform vec2 iResolution;
uniform float iTime;


varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
  float x = vertTexCoord.x * WIDTH;
  float y = vertTexCoord.y * HEIGHT;
  float v = 0.0;
  vec3 colorTotal = vec3(0.0);
  
  for (int i = 0; i < 88; i++) {
    vec3 ball = metaballs[i];
    float dx = ball.x - x;
    float dy = ball.y - y;
    float r = ball.z;
    float contribution = r * r / (dx * dx + dy * dy);
    v += contribution;
    colorTotal += metaballColors[i] * contribution / 7.5;
  }
  
  gl_FragColor = vec4(colorTotal, 1.0);
}