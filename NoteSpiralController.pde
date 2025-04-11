public class NoteSpiralController {
  private final NoteManager noteManager;
  private final MidiNotePlayer midiNotePlayer;
  private final NoteSpiralRenderer spiralRenderer;

  private float rotationAngle = 0;

  public NoteSpiralController(PApplet applet) {
    Theme theme = new ThemeProvider().getRandomTheme();
    this.noteManager = new NoteManager(applet.width, applet.height);
    this.midiNotePlayer = new MidiNotePlayer(noteManager.getNotes(), noteManager, "ProcessingToDAW");
    this.spiralRenderer = new NoteSpiralRenderer(applet.width, applet.height, theme, noteManager);
  }

  public void updateAndRender() {
    tf += tfRate;
    rotationAngle += rotationAngleRate;

    noteManager.updateNotes(tf, rotationAngle);
    midiNotePlayer.processNotes();
    spiralRenderer.render();
  }
}
