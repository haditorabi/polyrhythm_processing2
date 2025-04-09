ThemeLibrary themeLibrary;
public class NoteSpiralManager {
  private final List<VisualNote> visualNotes;
  private final Piano piano;
  private final MidiSender midi;
  private final SpiralRenderer spiralRenderer;
  private final LineToTop centerLine;
  private final Theme theme;

  private float tf = 0;
  private float rotationAngle = 0;

  public NoteSpiralManager() {
    AllowedNotes map = new AllowedNotes();
    visualNotes = map.getVisualNotes();
    piano = new Piano();
    midi = new MidiSender("ProcessingToDAW", piano, visualNotes);
    theme = getRandomTheme();
    centerLine = new LineToTop(width / 2, (height - 120) / 2);
    spiralRenderer = new SpiralRenderer(width, height, theme);
  }

  public void updateAndDraw() {
    tf += 0.00001;
    rotationAngle += 0.009;  // Gradually increment the rotation angle for smooth rotation

    float centerX = width / 2;
    float centerY = (height - 120) / 2;
    float threshold = 8;

    for (int i = 0; i < visualNotes.size(); i++) {
      VisualNote circle = visualNotes.get(i);
      circle.updatePosition(tf, i, visualNotes.size(), centerX, centerY, rotationAngle);

      if (abs(circle.x - centerX - 4) < threshold && abs(circle.y) < (height - 120) / 2 && !circle.hasPlayed) {
        midi.sendNote(circle.noteName, 100, 1400);
        circle.hasPlayed = true;
      }

      if (abs(circle.x - centerX) >= threshold) {
        circle.hasPlayed = false;
      }
    }

    spiralRenderer.render(visualNotes
      , piano
      , centerLine
      );
    midi.update();
  }

  private Theme getRandomTheme() {
    ThemeLibrary themeLibrary = new ThemeLibrary();
    return themeLibrary.getRandom(); // New utility class we’ll extract next
  }
}
