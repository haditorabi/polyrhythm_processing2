public class AppCore {
  private final UIManager uiManager;
  private final SceneRenderer sceneRenderer;
  private final InputHandler inputHandler;

  public AppCore(ControlP5 cp5, PApplet applet) {
    this.uiManager = new UIManager(cp5);
    this.sceneRenderer = new SceneRenderer(applet);
    this.inputHandler = new InputHandler();
  }

  public void setup() {
    size(1200, 800, P2D);
    background(0);
    noStroke();
    colorMode(HSB, 1, 1, 1, 1);
    pixelDensity(1);
    // PApplet app = sceneRenderer.getApplet(); // cleaner setup call
    // app.size(1200, 800, PApplet.P2D);
    // app.background(0);
    // app.noStroke();
    // app.colorMode(PApplet.HSB, 1, 1, 1, 1);
    // app.pixelDensity(1);

    uiManager.initializeUI();
  }

  public void draw() {
    sceneRenderer.render();
  }

  public void keyPressed(char key) {
    inputHandler.handleKeyPress(key, uiManager, sceneRenderer);
  }
}
