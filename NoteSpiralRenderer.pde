public class NoteSpiralRenderer {
  private final SpiralRenderer spiralRenderer;
  private final Piano piano;
  private final List<VisualNote> notes;
  private final LineToTop centerLine;

  public NoteSpiralRenderer(int width, int height, Theme theme, NoteManager noteManager) {
    this.spiralRenderer = new SpiralRenderer(width, height, theme);
    this.piano = noteManager.getPiano();
    this.notes = noteManager.getNotes();
    this.centerLine = new LineToTop(noteManager.getCenterX(), noteManager.getCenterY());
  }

  public void render() {
    spiralRenderer.render(notes, piano, centerLine);
  }
}
