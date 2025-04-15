#define PROCESSING_COLOR_SHADER

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
  // Apply Processing transform pipeline
  gl_Position = transform * vertex;

  // Pass color and texture coordinates to fragment shader
  vertColor = color;
  vertTexCoord = (texMatrix * vec4(texCoord, 1.0, 1.0)).xy;

  // OPTIONAL: If you want to apply custom manual screen mapping
  // vec4 pos = transform * vertex;
  // pos.xy = pos.xy * 2.0 - 1.0;
  // gl_Position = pos;
}
