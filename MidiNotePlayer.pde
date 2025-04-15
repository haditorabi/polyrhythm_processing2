public class MidiNotePlayer {
  private final MidiNoteSender noteSender;
  private final List<VisualNote> notes;
  private final CollisionDetector collisionDetector;

  public MidiNotePlayer(
    MidiNoteSender noteSender,
    List<VisualNote> notes,
    NoteManager noteManager
    ) {
    this.noteSender = noteSender;
    this.notes = notes;
    this.collisionDetector = new CollisionDetector(noteManager.getCenterX(), noteManager.getCenterY(), 16);
  }

  public void processNotes() {
    for (VisualNote note : notes) {
      if (note.isActive) {
        if (collisionDetector.isReadyToPlay(note)) {
          noteSender.sendNote(note.noteName, 120, 1000);
          note.hasPlayed = true;
          
        }

        if (collisionDetector.shouldResetPlay(note)) {
          note.hasPlayed = false;
        }
      }
    }

    noteSender.update();
  }
}
