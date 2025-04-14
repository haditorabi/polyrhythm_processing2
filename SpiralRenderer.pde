public class SpiralRenderer {
  private final PShader metaballShader;
  private final PGraphics buffer;
  private final Theme theme;
  private ThemeUtils themeUtils;

  public SpiralRenderer(int width, int height, Theme theme) {
    this.theme = theme;
    metaballShader = loadShader("frag.glsl", "vert.glsl");
    buffer = createGraphics(width, height, P3D);
    themeUtils = new ThemeUtils();
  }

  public void render(List<VisualNote> circles
    , Piano piano
    , GuidelineToTop line
    ) {
    float[] metaballData = new float[circles.size() * 3];
    float[] colorData = new float[circles.size() * 3];
    int circlesSize = circles.size();
    for (int i = 0; i < circles.size(); i++) {
      VisualNote c = circles.get(i);
      metaballData[i * 3] = c.x;
      metaballData[i * 3 + 1] = c.y;
      if (c.isGlowing) {
        metaballData[i * 3 + 2] = 35.0f ;
      } else {
        metaballData[i * 3 + 2] = 25.0f;
      }


      float[] glowingRgb = themeUtils.hexToRGB(theme.colors[0]);
      float[] rgb2 = themeUtils.hexToRGB(theme.colors[2]);

      float hue = map(i, 0, circles.size(), 20, 350);
      color cl = color(hue, 100, 100);
      String hexColor = "#" + hex(cl, 6);
      float[] rgb3 = themeUtils.hexToRGB(hexColor);
      if (c.isGlowing) {
        colorData[i * 3] = rgb2[0];
        colorData[i * 3 + 1] = rgb2[1];
        colorData[i * 3 + 2] = rgb2[2];
      } else {
        colorData[i * 3] = rgb3[0];
        colorData[i * 3 + 1] = rgb3[1];
        colorData[i * 3 + 2] = rgb3[2];
      }
    }

    buffer.beginDraw();
    buffer.background(unhex(theme.background.substring(1) + "FF"));
    buffer.shader(metaballShader);
    metaballShader.set("metaballs", metaballData, 3);
    metaballShader.set("metaballColors", colorData, 3);
    metaballShader.set("WIDTH", (float) width);
    metaballShader.set("HEIGHT", (float) height);

    buffer.rect(0, 0, width, height);
    buffer.resetShader();
    for (int i = 0; i < circles.size(); i++) {
      VisualNote c = circles.get(i);
      c.draw(buffer);
    }
    piano.draw(buffer);
    line.draw(buffer);
    buffer.endDraw();

    image(buffer, 0, 0, width, height);
  }
}
