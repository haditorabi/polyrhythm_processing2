public class VisualNote {
  private final String noteName;
  public final int midi;
  public float x, y;
  private float size = 8;
  private color noteColor = color(255, 200);
  private boolean hasPlayed = false;
  //private GlowEffect glow = new GlowEffect();

  public VisualNote(String name, int midi) {
    this.noteName = name;
    this.midi = midi;
  }

  public void updatePosition(float tf, int index, int total, float centerX, float centerY, float rotation) {
    float dist = sqrt(index / (float) total) * (height - 120) * 0.45f;
    float angle = TWO_PI * tf * index;

    float baseX = dist * cos(angle) + centerX;
    float baseY = dist * sin(angle) + centerY;

    x = cos(rotation) * (baseX - centerX) - sin(rotation) * (baseY - centerY) + centerX;
    y = sin(rotation) * (baseX - centerX) + cos(rotation) * (baseY - centerY) + centerY;
  }

  public void draw(PGraphics pg) {
    //glow.update();
    //glow.draw(pg, x, y, size);

    pg.fill(noteColor);
    pg.noStroke();
    pg.ellipse(x, y, size, size);

    pg.fill(255);
    pg.textAlign(CENTER, CENTER);
    pg.textSize(11);
    pg.text(noteName, x, y - size / 2 - 10);
  }

  public void triggerGlow() {
    //glow.trigger();
    hasPlayed = true;
  }

  public void setHasPlayed(boolean state) {
    hasPlayed = state;
  }

  public boolean isReadyToPlay(float centerX, float centerY, float threshold) {
    return abs(x - centerX) < threshold && abs(y) < height / 2 && !hasPlayed;
  }

  public boolean shouldResetPlay(float centerX, float threshold) {
    return abs(x - centerX) >= threshold;
  }
}
