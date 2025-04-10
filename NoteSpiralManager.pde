ThemeLibrary themeLibrary;
 

public class NoteSpiralManager {
  private final List<VisualNote> visualNotes;
  private final Piano piano;
  private final MidiSender midi;
  private final SpiralRenderer spiralRenderer;
  private final LineToTop centerLine;
  private final Theme theme;
  private final CollisionDetector collisionDetector;

  private float rotationAngle = 0;

  public NoteSpiralManager() {


    AllowedNotes map = new AllowedNotes();
    visualNotes = map.getVisualNotes();
    piano = new Piano();
    midi = new MidiSender("ProcessingToDAW", piano, visualNotes);
    theme = getRandomTheme();
    centerLine = new LineToTop(width / 2, (height - 120) / 2);
    spiralRenderer = new SpiralRenderer(width, height, theme);

    float centerX = width / 2;
    float centerY = (height - 120) / 2;
    float threshold = 8;
    collisionDetector = new CollisionDetector(centerX, centerY, threshold);
  }

  public void updateAndDraw() {
    tf += tfRate;
    rotationAngle += rotationAngleRate; // Gradually increment the rotation angle for smooth rotation

    for (VisualNote note : visualNotes) {
      note.updatePosition(tf, visualNotes.indexOf(note), visualNotes.size(), width / 2, (height - 120) / 2, rotationAngle);

      // Use CollisionDetector for collision logic
      if (collisionDetector.isReadyToPlay(note)) {
        midi.sendNote(note.noteName, 100, 1400);
        note.hasPlayed = true;
      }

      if (collisionDetector.shouldResetPlay(note)) {
        note.hasPlayed = false;
      }
    }

    spiralRenderer.render(visualNotes, piano, centerLine);
    midi.update();
  }

  private Theme getRandomTheme() {
    ThemeLibrary themeLibrary = new ThemeLibrary();
    return themeLibrary.getRandom();
  }
}
