#define PROCESSING_COLOR_SHADER

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec2 vertTexCoord;

void main() {
  gl_Position = transform * vertex;
  vertColor = color;
  vertTexCoord = (texMatrix * vec4(texCoord, 1.0, 1.0)).xy;
}