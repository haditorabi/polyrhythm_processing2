AppController app;

void setup() {
  app = new AppController();
  app.setup();
}

void draw() {
  app.draw();
}

void keyPressed() {
  app.keyPressed(key);
}
