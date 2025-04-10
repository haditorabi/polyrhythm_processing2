public class InputHandler {
  private boolean guiVisible = true;

  public void handleKeyPress(char key, UIManager uiManager, SceneRenderer sceneRenderer) {
    switch (key) {
      case ' ':
        boolean paused = !sceneRenderer.isPaused();
        sceneRenderer.setPaused(paused);
        System.out.println("Paused: " + paused);
        break;

      case 'h':
      case 'H':
        guiVisible = !guiVisible;
        uiManager.setGuiVisible(guiVisible);
        System.out.println("GUI visible: " + guiVisible);
        break;

      default:
        System.out.println("Unhandled key: " + key);
    }
  }
}
