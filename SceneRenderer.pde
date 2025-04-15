import processing.core.PApplet;

public class SceneRenderer {
  private final PApplet applet;
  private final NoteSpiralController noteSpiralController;
  private boolean paused = true;

  public SceneRenderer(PApplet applet) {
    this.applet = applet;
    this.noteSpiralController = new NoteSpiralController(applet);
  }

  public void setPaused(boolean paused) {
    this.paused = paused;
  }
  public boolean isPaused() {
    return this.paused;
  }
  public void render() {

    if (!paused) {
      applet.background(0);
      noteSpiralController.updateAndRender();
    } else {
      displayPauseOverlay();
    }
  }

  private void displayPauseOverlay() {
    applet.fill(applet.color(255));
    applet.textSize(48);
    applet.textAlign(PApplet.CENTER, PApplet.CENTER);
    applet.text("Paused", applet.width / 2f, applet.height / 1.1f);
  }
  public PApplet getApplet() {
    return applet;
  }
}
