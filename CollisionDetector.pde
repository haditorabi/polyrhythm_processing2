public class CollisionDetector {
  private final float canvasHeight;
  private final float threshold;

  public CollisionDetector( float threshold) {
    this.canvasHeight = height;
    this.threshold = threshold;
  }

  public boolean isReadyToPlay(VisualNote note) {
    float triggerY = canvasHeight / 1.21f - threshold;
    return note.y > triggerY && !note.hasPlayed;
  }

  public boolean shouldResetPlay(VisualNote note) {
    float resetY = canvasHeight / 1.21f - threshold * 2;
    return note.y < resetY && note.hasPlayed;
  }
}
