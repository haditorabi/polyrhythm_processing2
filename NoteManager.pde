public class NoteManager {
  private final List<VisualNote> notes;
  private final Piano piano;
  private final CollisionDetector collisionDetector;
  private final float centerX, centerY;

  public NoteManager(int canvasWidth, int canvasHeight, List<VisualNote> notes) {
    AllowedNotes allowedNotes = new AllowedNotes();
    this.notes = notes;
    this.piano = new Piano();

    this.centerX = canvasWidth / 2f;
    this.centerY =  (canvasHeight/ 1.21f) / 2;

    this.collisionDetector = new CollisionDetector(8);
  }

  public void updateNotes(float tf, float rotationAngle) {
    for (int i = 0; i < notes.size(); i++) {
      VisualNote note = notes.get(i);
      note.updatePosition(tf, i, notes.size(), centerX, centerY, rotationAngle);
    }
  }

  public List<VisualNote> getNotes() {
    return notes;
  }

  public Piano getPiano() {
    return piano;
  }

  public CollisionDetector getCollisionDetector() {
    return collisionDetector;
  }

  public float getCenterX() {
    return centerX;
  }

  public float getCenterY() {
    return centerY;
  }
}
