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

uniform vec2 lineStart;
uniform vec2 lineEnd;
uniform float lineGlowIntensity; // controls how strong the glow is
uniform vec3 lineGlowColor;      // controls the color of the glow

float glowLine(vec2 p, vec2 a, vec2 b, float thickness) {
  vec2 pa = p - a;
  vec2 ba = b - a;
  float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
  float d = length(pa - ba * h);
  return smoothstep(thickness, 0.0, d);
}

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
  vec2 uv = vertTexCoord * vec2(WIDTH, HEIGHT);
  float lineGlow = glowLine(uv, lineStart, lineEnd, lineGlowIntensity);

  vec3 lineColor = vec3(1.0, 0.8, 0.2);
  colorTotal += lineGlowColor * lineGlow;

  gl_FragColor = vec4(colorTotal, 1.0);
}