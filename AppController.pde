public class AppController {
  private NoteSpiralManager noteSpiralManager;
  private boolean isPaused = false;
  ControlP5 cp5;

  public AppController(ControlP5 controllerP5) {
    cp5 = controllerP5;
    noteSpiralManager = new NoteSpiralManager(cp5);
  }

  public void setup() {
    size(1200, 800, P2D);
    background(0);
    noStroke();
    colorMode(HSB, 1, 1, 1, 1);
    pixelDensity(1);
  }

  public void draw() {
    if (!isPaused) {
      noteSpiralManager.updateAndDraw();
    } else {
      displayPauseOverlay();
    }
  }

  public void keyPressed(char key) {
    if (key == ' ') {
      isPaused = !isPaused;
      println("Paused: " + isPaused);
    }
    if (key == 'h' || key == 'H') {
      isGuiVisible = !isGuiVisible;
      cp5.setVisible(isGuiVisible);
    }
  }

  private void displayPauseOverlay() {
    fill(color(#FFFFFF));
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Paused", width / 2, height / 1.13);
  }
}
