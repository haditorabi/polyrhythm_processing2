public class PianoKeyHighlighter implements NoteListener {
  private final Piano piano;

  public PianoKeyHighlighter(Piano piano) {
    this.piano = piano;
  }

  @Override
    public void onNoteStateChanged(int midi, boolean isActive) {
    piano.setKeyActive(midi, isActive);
  }
}
