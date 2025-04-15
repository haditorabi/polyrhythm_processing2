public class VisualNoteHighlighter implements NoteListener {
  private final List<VisualNote> notes;

  public VisualNoteHighlighter(List<VisualNote> notes) {
    this.notes = notes;
  }

  @Override
    public void onNoteStateChanged(int midi, boolean isActive) {
    for (VisualNote note : notes) {
      if (note.midi == midi) {
        note.setGlowing(isActive);
        break;
      }
    }
  }
}
