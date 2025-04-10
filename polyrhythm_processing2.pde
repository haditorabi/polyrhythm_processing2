import controlP5.*;
ControlP5 cp5;
AppController app;

void setup() {
  cp5 = new ControlP5(this);
  app = new AppController(cp5);
  app.setup();
}

void draw() {
  app.draw();
}

void keyPressed() {
  app.keyPressed(key);
}
