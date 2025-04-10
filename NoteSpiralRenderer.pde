public class NoteSpiralRenderer {
  private final NoteSpiralManager manager;

  public NoteSpiralRenderer() {
    this.manager = new NoteSpiralManager();
  }

  public void updateAndRender() {
    manager.updateAndDraw();
  }
}