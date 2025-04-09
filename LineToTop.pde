class LineToTop {
  float startX, startY;  // The center of the circle set (spiral center)
  float endX, endY;      // The highest point of the screen (0, 0)
  color lineColor = color(#FFFFFF);       // Line color (set externally)
  float thickness = 1.0f;       // Line thickness (set inside the class)

  // Constructor to initialize the start and end points
  LineToTop(float startX, float startY) {
    this.startX = startX;
    this.startY = startY;
    this.endX = width / 2;  // Always start from the center of the screen (x)
    this.endY = 0;          // Always end at the top of the screen (y = 0)
    this.thickness = 10;     // Default thickness (can be changed inside the class)
  }

  // Method to set the color externally
  void setLineColor(color c) {
    this.lineColor = c;
  }

  // Method to set the thickness inside the class
  void setThickness(float thickness) {
    this.thickness = thickness;
  }

  // Method to draw the line on the screen
  void draw(PGraphics shaderBuffer) {
    shaderBuffer.stroke(lineColor);         // Set the line color
    shaderBuffer.strokeWeight(1);    // Set the thickness of the line
    shaderBuffer.line(startX, startY, endX, endY);  // Draw the line from the center to the top of the screen
    shaderBuffer.noStroke();
  }
}
