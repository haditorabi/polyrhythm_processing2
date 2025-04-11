public class MidiNotePlayer {
  private final MidiSender midiSender;
  private final List<VisualNote> notes;
  private final CollisionDetector detector;

  public MidiNotePlayer(List<VisualNote> notes, NoteManager noteManager, String deviceName) {
    this.notes = notes;
    this.midiSender = new MidiSender(deviceName, noteManager.getPiano(), notes);
    this.detector = new CollisionDetector(noteManager.getCenterX(), noteManager.getCenterY(), 8);
  }

  public void processNotes() {
    for (VisualNote note : notes) {
      if (detector.isReadyToPlay(note)) {
        midiSender.sendNote(note.noteName, 100, 1400);
        note.hasPlayed = true;
      }

      if (detector.shouldResetPlay(note)) {
        note.hasPlayed = false;
      }
    }

    midiSender.update();
  }
}
