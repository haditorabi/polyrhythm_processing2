import processing.core.PApplet;

public class SceneRenderer {
  private final PApplet applet;
  private final NoteSpiralRenderer spiralRenderer;
  private boolean paused = false;

  public SceneRenderer(PApplet applet) {
    this.applet = applet;
    this.spiralRenderer = new NoteSpiralRenderer();
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
      spiralRenderer.updateAndRender();
    } else {
      displayPauseOverlay();
    }
  }

  private void displayPauseOverlay() {
    applet.fill(applet.color(255));
    applet.textSize(48);
    applet.textAlign(PApplet.CENTER, PApplet.CENTER);
    applet.text("Paused", applet.width / 2f, applet.height / 1.43f);
  }
  public PApplet getApplet() {
  return applet;
}
}
