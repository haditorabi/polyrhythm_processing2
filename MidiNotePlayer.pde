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
    this.collisionDetector = new CollisionDetector((16.0f / 1920) * width);
  }

  public void processNotes() {
    for (VisualNote note : notes) {
      if (note.isActive) {
        if (collisionDetector.isReadyToPlay(note)) {
          if(note.x < width/2) {
            noteSender.sendNote(note.noteName, 120, 1000, 1);
          } else {
            noteSender.sendNote(note.noteName, 120, 1000, 2);
          }
          // println("Playing note: " + note.noteName);
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
