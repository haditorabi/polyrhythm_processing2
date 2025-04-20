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
    //hd
    //size(1280, 720, P2D);
    //full-hd
    //  size(1920, 1080, P2D);
    //2k
    //size(2560, 1440, P2D);
    //4k
      size(3840, 2160, P2D);



    background(0);
    noStroke();
    colorMode(HSB, 360, 100, 100, 100);
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
