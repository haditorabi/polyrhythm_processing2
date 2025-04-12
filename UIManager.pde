import controlP5.*; 
float tfRate = 0.000005f;
float rotationAngleRate = 0.0155f;
boolean isGuiVisible = true;
float tf = 0;

public class UIManager {
  private final ControlP5 cp5;

  public UIManager(ControlP5 cp5) {
    this.cp5 = cp5;
  }

  public void initializeUI() {
    cp5.addSlider("tfRate")
      .setPosition(20, 60)
      .setSize(200, 20)
      .setRange(0.0, 0.0003)
      .setValue(tfRate)
      .setDecimalPrecision(6)
      .setLabel("TF Rate Value");
    cp5.addSlider("rotationAngleRate")
      .setPosition(20, 100)
      .setSize(200, 20)
      .setRange(0.0, 0.1)
      .setValue(rotationAngleRate)
      .setDecimalPrecision(6)
      .setLabel("Rotation Angle");
    cp5.addSlider("tf")
      .setPosition(20, 20)
      .setSize(200, 20)
      .setRange(0.0, 1.0)
      .setValue(tf)
      .setDecimalPrecision(8)
      .setLabel("TF Value");
  }
  public void setGuiVisible(boolean visible) {
    cp5.setVisible(visible);
  }
}
