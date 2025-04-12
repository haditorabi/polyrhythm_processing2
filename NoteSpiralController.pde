
public class NoteSpiralController {
  private final NoteManager noteManager;
  public final MidiNotePlayer midiNotePlayer;
  private final NoteSpiralRenderer spiralRenderer;
  private final List<VisualNote> visualNotes;
  private final Piano piano;
  private float rotationAngle = 0;

  public NoteSpiralController(PApplet applet) {
    Theme theme = new ThemeProvider().getRandomTheme();
    AllowedNotes allowedNotes = new AllowedNotes();
    this.visualNotes = allowedNotes.getVisualNotes();
    this.noteManager = new NoteManager(applet.width, applet.height, visualNotes);
    NoteMap noteMap = new NoteMap();
    MidiNoteSender sender = new MidiNoteSender("ProcessingToDAW", noteMap);
    this.piano = noteManager.getPiano();
    sender.addNoteListener(new PianoKeyHighlighter(piano));
    sender.addNoteListener(new VisualNoteHighlighter(visualNotes));
    midiNotePlayer = new MidiNotePlayer(sender, visualNotes, noteManager);
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
