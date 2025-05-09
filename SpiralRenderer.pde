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
  , LineToTop line
  ) {
    float[] metaballData = new float[circles.size() * 3];
    float[] colorData = new float[circles.size() * 3];

    for (int i = 0; i < circles.size(); i++) {
      VisualNote c = circles.get(i);
      metaballData[i * 3] = c.x;
      metaballData[i * 3 + 1] = c.y;
      metaballData[i * 3 + 2] = 20;

      float[] rgb = themeUtils.hexToRGB(theme.colors[0]);
      colorData[i * 3] = rgb[0];
      colorData[i * 3 + 1] = rgb[1];
      colorData[i * 3 + 2] = rgb[2];
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

    piano.draw(buffer);
    line.draw(buffer);
    buffer.endDraw();

    image(buffer, 0, 0, width, height);
  }
}
