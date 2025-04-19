public class VisualNote {
  private final String noteName;
  public final int midi;
  public float x, y;
  private float size = (38.0f / 1920) * width;
  private color noteColor = color(255, 200);
  private boolean hasPlayed = false;
  public boolean isGlowing = false;
  public boolean isActive = false;
  public float currentSize;
  public long glowStartTime = -1;
  float bounceAmplitude = 1; // How strong the bounce is
  float bounceDamping = 0.025; // How quickly the bounce diminishes (0-1)
  float lastSinValue = 0; // To detect when sin changes sign
  private PImage image;


  public VisualNote(String name, int midi, boolean isActive, PImage image, float size) {
    this.noteName = name;
    this.midi = midi;
    this.image = image;
    this.isActive = isActive;
    this.size = size;
    this.currentSize = (45.0f / 1920) * width;
  }

public void updatePosition(float tf, int index, int total, float centerX, float centerY, float rotation) {
  float dist = getDist(index, total);

  float[] orbitPeriods = {88, 225, 365, 687, 4333, 10759, 30687, 60190};
  float period = orbitPeriods[index % orbitPeriods.length];

  float normalizedIndex = map(index, 2, total, total/1.25, total);
  // float angle = PI * tf * normalizedIndex;
float scaledPeriod = period / 2000.0; // Makes all planets orbit 10x faster
float angle = TWO_PI * (tf / scaledPeriod);
  
  // Calculate the sin value
  float sinValue = sin(angle);
  
  // Detect if we've crossed the "obstacle" - when sin changes from positive to negative
  if (sinValue < 0 && lastSinValue >= 0) {
    // Hit detected! Initialize bounce effect
    bounceAmplitude = 0.4; // Adjust this value for stronger/weaker initial bounce
  }
  
  // Store the current sin value for next frame
  lastSinValue = sinValue;
  
  // Apply bounce effect and damping
  bounceAmplitude *= bounceDamping;
  
  // Apply the position with bounce effect
  x = dist * cos(angle) + centerX;
  
  // Add the bounce to the y-position (delays the recovery after hit)
  // y = dist * -abs(sinValue) + centerY + (dist * bounceAmplitude * (1 - abs(sinValue)));
  y = dist * sin(angle) + centerY;
  
  if (frameCount%24 == 0 && index == 0) {
    println(tf);
  }
}


  public void draw(PGraphics pg) {

    // pg.fill(noteColor);
    // pg.noStroke();
    // pg.ellipse(x, y, size, size);
    if (image != null) {
      pg.tint(255, 255);      // Draw image centered at x, y and scaled to note size
      pg.imageMode(CENTER);
      pg.image(image, x, y, size, size);
      pg.noTint();
    }

    // pg.fill(255);
    // pg.textAlign(CENTER, CENTER);
    // pg.textSize(11);
    // pg.text(noteName, x, y - size / 2 - 10);
  }

  public void setGlowing(boolean state) {
    isGlowing = state;
    glowStartTime = millis();
  }
  public void setActive(boolean state) {
    isActive = state;
  }
  public float getDist(int index, int total) {
    return map(index, 0, total, (height /1.24) - (height/1.45 ), (height /1.24) / 2);
  }

  public void setHasPlayed(boolean state) {
    hasPlayed = state;
  }
  public void setSize(int circleSize) {
    size = circleSize;
  }
  public void setImage(PImage img) {
    this.image = img;
  }

}
