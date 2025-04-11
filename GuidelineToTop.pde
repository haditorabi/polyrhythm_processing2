public class GuidelineToTop {
  private final float startX;
  private final float startY;
  private final float endX;
  private final float endY;

  private int lineColor;
  private float thickness;

  public GuidelineToTop(float centerX, float centerY) {
    this.startX = centerX;
    this.startY = centerY;
    this.endX = width / 2f;
    this.endY = 0;
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
  }
}
