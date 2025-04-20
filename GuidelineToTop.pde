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
    this.startX = (width / 2) + (width / 17.6);
    this.startY = (height / 1.21f) / 2;
    this.endX = ((height / 1.3f) / 2) + (width / 2);
    this.endY = (height / 1.21f) / 2;
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
    buffer.stroke(lineColor);
    buffer.strokeWeight(thickness);
    buffer.line(startX, startY, endX, endY);
    buffer.noStroke();
    if (millis() - lastHitTime > glowDropDelay) {
      glowIntensity = lerp(glowIntensity, glowMin, 0.05);
    }
  }

  void onNoteHitLine() {
  glowIntensity = glowMax;
  lastHitTime = millis();
  }
}
