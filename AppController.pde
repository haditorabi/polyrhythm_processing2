public class AppController {
  private NoteSpiralManager noteSpiralManager;
  private boolean isPaused = false;

  public AppController() {
    noteSpiralManager = new NoteSpiralManager();
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
  }

  private void displayPauseOverlay() {
    fill(color(#FFFFFF));
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Paused", width / 2, height / 1.23);
  }
}
