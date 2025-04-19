public class CollisionDetector {
  private final float canvasHeight;
  private final float threshold;

  public CollisionDetector( float threshold) {
    this.canvasHeight = height;
    this.threshold = threshold;
  }

  public boolean isReadyToPlay(VisualNote note) {
    
    float triggerY = ((height / 1.21f) / 2) - threshold;
    float triggerX = (width / 2);
    return note.y > triggerY && note.x > (width / 2) && !note.hasPlayed;
  }

  public boolean shouldResetPlay(VisualNote note) {
    float resetY = ((height / 1.21f) / 2) - (threshold * 2);
    return note.y < resetY && note.hasPlayed;
  }
}
