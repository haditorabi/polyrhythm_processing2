public class CollisionDetector {
  private final float centerX;
  private final float centerY;
  private final float threshold;

  public CollisionDetector(float centerX, float centerY, float threshold) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.threshold = threshold;
  }

  public boolean isReadyToPlay(VisualNote note) {
    return abs(note.x - centerX - 4) < threshold && abs(note.y) < centerY && !note.hasPlayed;
  }

  public boolean shouldResetPlay(VisualNote note) {
    return abs(note.x - centerX) >= threshold;
  }
}