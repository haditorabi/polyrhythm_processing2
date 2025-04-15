
public class NoteSpiralController {
  private final NoteManager noteManager;
  public final MidiNotePlayer midiNotePlayer;
  private final NoteSpiralRenderer spiralRenderer;
  private final List<VisualNote> visualNotes;
  private final Piano piano;
  private float rotationAngle = 0;
  private final GuidelineToTop centerLine;


  public NoteSpiralController(PApplet applet) {
    Theme theme = new ThemeProvider().getRandomTheme();
    AllowedNotes allowedNotes = new AllowedNotes();
    this.visualNotes = allowedNotes.getVisualNotes();
    this.noteManager = new NoteManager(width, height, visualNotes);
    this.centerLine = new GuidelineToTop(noteManager.getCenterX(), noteManager.getCenterY());
    NoteMap noteMap = new NoteMap();
    MidiNoteSender sender = new MidiNoteSender("ProcessingToDAW", noteMap, centerLine);
    this.piano = noteManager.getPiano();
    sender.addNoteListener(new PianoKeyHighlighter(piano));
    sender.addNoteListener(new VisualNoteHighlighter(visualNotes));
    midiNotePlayer = new MidiNotePlayer(sender, visualNotes, noteManager);
    this.spiralRenderer = new NoteSpiralRenderer(applet.width, applet.height, theme, noteManager, centerLine);
  }

  public void updateAndRender() {
    tf += tfRate;
    rotationAngle += rotationAngleRate;
    noteManager.updateNotes(tf, rotationAngle);
    midiNotePlayer.processNotes();
    spiralRenderer.render();
  }
}
