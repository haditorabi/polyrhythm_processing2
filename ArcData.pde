public class ArcData {
  public float x, y, radius;
  public float startAngle, endAngle; // in radians
  public float thickness;
  public float r, g, b, a;

  public ArcData(float x, float y, float radius, float startAngle, float endAngle, float thickness, float r, float g, float b, float a) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.startAngle = startAngle;
    this.endAngle = endAngle;
    this.thickness = thickness;
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }
}
