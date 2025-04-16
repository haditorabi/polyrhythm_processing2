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
    float dist = getDist(index, total);
    float normalizedIndex = map(index, 2, total, total/1.25, total);
    float angle = TWO_PI * tf * normalizedIndex;

    x = dist * cos(angle) + centerX;
    y = dist * -abs(sin(angle)) + centerY;

    if (frameCount%24 == 0 && index == 0) {
      // println(tf);
    }
    
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
  public float getDist(int index, int total) {
    return map(index, 0, total, (height /1.24) - (height/1.35 ), (height /1.24));
  }

  public void setHasPlayed(boolean state) {
    hasPlayed = state;
  }
  public void setSize(int circleSize) {
    size = circleSize;
  }
}
