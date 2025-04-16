#define MAX_ARCS 21
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


uniform vec3 arcCenters[MAX_ARCS];   // x, y, radius
uniform vec3 arcColors[MAX_ARCS];    // RGB
uniform float arcStartAngles[MAX_ARCS]; // in radians
uniform float arcEndAngles[MAX_ARCS];   // in radians
uniform float arcThicknesses[MAX_ARCS]; // in pixels
uniform float arcOpacities[MAX_ARCS];


float drawArc(vec2 p, vec3 center, float startAngle, float endAngle, float thickness) {
  vec2 toPoint = p - center.xy;
  float angle = atan(toPoint.y, toPoint.x);
  if (angle < 0.0) angle += 6.28318530718; // wrap angle [0, 2PI]

  float dist = abs(length(toPoint) - center.z);
  float inArc = smoothstep(thickness + 1.0, thickness, dist); // arc thickness

  // Check if point is within angle range
  float withinAngle = step(startAngle, angle) * step(angle, endAngle);
  return inArc * withinAngle;
}

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

  vec3 arcColorSum = vec3(0.0);
  for (int i = 0; i < MAX_ARCS; i++) {
    float arc = drawArc(vec2(x, y), arcCenters[i], arcStartAngles[i], arcEndAngles[i], arcThicknesses[i]);
    arcColorSum += arcColors[i] * arc * arcOpacities[i]; // ✅ blend with opacity
  }


  vec3 colorTotal = arcColorSum;

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
  colorTotal += lineGlowColor * lineGlow;

  gl_FragColor = vec4(colorTotal, 1.0);
}
