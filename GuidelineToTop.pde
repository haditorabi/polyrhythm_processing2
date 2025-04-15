public class GuidelineToTop {
  public final float startX;
  public final float startY;
  public final float endX;
  public final float endY;

  float glowIntensity = 13.0;
  float glowMax = 13.0;
  float glowMin = 1.0;
  float lastHitTime = 0;
  int glowDropDelay = 50;
  color lineGlowColor = color(255, 200, 50);

  private int lineColor;
  private float thickness;

  public GuidelineToTop(float centerX, float centerY) {
    this.startX = width * 0.02f;
    this.startY = height /1.21f;
    this.endX = width * 0.98f;
    this.endY = height /1.21f;
    this.lineColor = color(255); // Default white
    this.thickness = 1.0f;
  }

  public void setLineColor(int colour) {
    this.lineColor = colour;
  }

  public void setThickness(float thickness) {
    this.thickness = thickness;
  }

  public void draw(PGraphics buffer) {
    // buffer.stroke(lineColor);
    // buffer.strokeWeight(thickness);
    // buffer.line(startX, startY, endX, endY);
    // buffer.noStroke();
    if (millis() - lastHitTime > glowDropDelay) {
      glowIntensity = lerp(glowIntensity, glowMin, 0.05);
    }
  }

  void onNoteHitLine() {
  glowIntensity = glowMax;
  lastHitTime = millis();
  }
}
