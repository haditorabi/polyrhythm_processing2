ThemeLibrary themeLibrary;
 
float tfRate = 0.00001f;
float rotationAngleRate = 0.009f;
boolean isGuiVisible = true;

public class NoteSpiralManager {
  private final List<VisualNote> visualNotes;
  private final Piano piano;
  private final MidiSender midi;
  private final SpiralRenderer spiralRenderer;
  private final LineToTop centerLine;
  private final Theme theme;

  private float tf = 0;
  private float rotationAngle = 0;
  
  public NoteSpiralManager(ControlP5 cp5) {
    
    cp5.addSlider("tfRate")
     .setPosition(20, 20)
     .setSize(200, 20)
     .setRange(0.0, 0.0003)
     .setValue(tfRate)
     .setDecimalPrecision(6)
     .setLabel("TF Value");
    cp5.addSlider("rotationAngleRate")
       .setPosition(20, 60)
       .setSize(200, 20)
       .setRange(0.0, 0.1)
       .setValue(rotationAngleRate)
       .setDecimalPrecision(6)
       .setLabel("Rotation Angle");
       
    AllowedNotes map = new AllowedNotes();
    visualNotes = map.getVisualNotes();
    piano = new Piano();
    midi = new MidiSender("ProcessingToDAW", piano, visualNotes);
    theme = getRandomTheme();
    centerLine = new LineToTop(width / 2, (height - 120) / 2);
    spiralRenderer = new SpiralRenderer(width, height, theme);
  }

  public void updateAndDraw() {
    tf += tfRate;
    rotationAngle += rotationAngleRate;  // Gradually increment the rotation angle for smooth rotation
    println(rotationAngleRate);
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
