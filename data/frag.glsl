#ifdef GL_ES
precision highp float;
precision mediump int;
#endif

uniform float iTime;

uniform float WIDTH;
uniform float HEIGHT;
uniform vec3 metaballs[88];
uniform vec3 metaballColors[88];

varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
  vec2 fragCoord = vertTexCoord * vec2(WIDTH, HEIGHT);
  vec2 uv = gl_FragCoord.xy / vec2(WIDTH, HEIGHT);

  // === 1. Background rainbow color effect ===
  vec3 rainbow = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0.0, 2.0, 4.0));

  // === 2. Metaballs effect ===
  float v = 0.0;
  vec3 metaballColor = vec3(0.0);

  for (int i = 0; i < 88; i++) {
    vec3 ball = metaballs[i];
    float dx = ball.x - fragCoord.x;
    float dy = ball.y - fragCoord.y;
    float r = ball.z;
    float distSq = dx * dx + dy * dy;
    if (distSq > 0.0001) {
      float contribution = r * r / distSq;
      v += contribution;
      metaballColor += metaballColors[i] * (contribution / 1.5);
    }
  }

  // === 3. Combine Effects ===
  // Option A: Blend metaball color into rainbow background
  float intensity = clamp(v / 2.0, 0.95, 0.95); // normalize intensity
  vec3 finalColor = mix(rainbow, metaballColor, intensity);

  gl_FragColor = vec4(finalColor, 1.0);
}
