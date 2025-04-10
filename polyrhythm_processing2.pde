import controlP5.*;

ControlP5 cp5;
AppCore app;

void setup() {
  cp5 = new ControlP5(this);
  app = new AppCore(cp5, this);
  app.setup();
}

void draw() {
  app.draw();
}

void keyPressed() {
  app.keyPressed(key);
}
