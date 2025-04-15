public class VisualNote {
  private final String noteName;
  public final int midi;
  public float x, y;
  private float size = 0;
  private color noteColor = color(255, 200);
  private boolean hasPlayed = false;
  private boolean isGlowing = false;
  public boolean isActive = false;

  public VisualNote(String name, int midi, boolean isActive) {
    this.noteName = name;
    this.midi = midi;
    this.isActive = isActive;
  }

  public void updatePosition(float tf, int index, int total, float centerX, float centerY, float rotation) {
    float dist = map(index, 0, total, (height/27 ), (height /1.24));
    float normalizedIndex = map(index, 2, total, total/1.25, total);
    float angle = TWO_PI * tf * normalizedIndex;

    x = dist * cos(angle) + centerX;
    y = dist * -abs(sin(angle)) + centerY;

    println(tf);
  }

  public void draw(PGraphics pg) {

    pg.fill(noteColor);
    pg.noStroke();
    pg.ellipse(x, y, size, size);

    //pg.fill(255);
    //pg.textAlign(CENTER, CENTER);
    //pg.textSize(11);
    //pg.text(noteName, x, y - size / 2 - 10);
  }

  public void setGlowing(boolean state) {
    isGlowing = state;
  }
  public void setActive(boolean state) {
    isActive = state;
  }

  public void setHasPlayed(boolean state) {
    hasPlayed = state;
  }
  public void setSize(int circleSize) {
    size = circleSize;
  }
  public boolean isReadyToPlay(float centerX, float centerY, float threshold) {
    return abs(x - centerX) < threshold && abs(y) < height / 2 && !hasPlayed;
  }

  public boolean shouldResetPlay(float centerX, float threshold) {
    return abs(x - centerX) >= threshold;
  }
}
