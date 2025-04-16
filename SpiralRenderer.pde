public class SpiralRenderer {
  private final PShader metaballShader;
  private final PGraphics buffer;
  private final Theme theme;
  private ThemeUtils themeUtils;
  private List<ArcData> arcs = new ArrayList<>();
  
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
    if(arcs.size() == 0) {
      for (int i = 0; i < circlesSize; i++) {
        VisualNote c = circles.get(i);

        float hueX = map(i, 0, circlesSize, 20, 350);
        color clX = color(hueX, 80, 90);
        String hexColorX = "#" + hex(clX, 6);
        float[] rgbX = themeUtils.hexToRGB(hexColorX);

        arcs.add(new ArcData(
          width / 2.0f,
        height / 1.21f,
         c.getDist(i, circles.size()),
          PI,
           PI*2,
           (16.0f / 1920) * width,
           rgbX[0],
           rgbX[1],
           rgbX[2],
           0.25f));
      }
    }
    for (int i = 0; i < circles.size(); i++) {
      VisualNote c = circles.get(i);
      metaballData[i * 3] = c.x;
      metaballData[i * 3 + 1] = c.y;
      if (c.isGlowing) {
        // c.setSize(25);
        metaballData[i * 3 + 2] = (65.0f / 1920) * width ;
      } else if (!c.isActive) {
        // c.setSize(20);
        metaballData[i * 3 + 2] = (30.0f / 1920) * width;
      } else {
        // c.setSize(25);
        metaballData[i * 3 + 2] = (45.0f / 1920) * width;
      }


      float[] glowingRgb = themeUtils.hexToRGB(theme.colors[0]);

      float hue = map(i, 0, circles.size(), 20, 350);
      color cl = color(hue, c.isActive ? c.isGlowing ? 75 : 85 : 60, c.isActive ? c.isGlowing ? 50 : 30 : 60);
      String hexColor = "#" + hex(cl, 6);
      float[] rgb3 = themeUtils.hexToRGB(hexColor);
      //if (c.isGlowing && c.isActive) {
      //  colorData[i * 3] = rgb2[0];
      //  colorData[i * 3 + 1] = rgb2[1];
      //  colorData[i * 3 + 2] = rgb2[2];
      //} else {
      colorData[i * 3] = rgb3[0];
      colorData[i * 3 + 1] = rgb3[1];
      colorData[i * 3 + 2] = rgb3[2];
      //}
    }
    float[] rgb2 = themeUtils.hexToRGB(theme.colors[2]);
    buffer.beginDraw();
    buffer.background(unhex(theme.background.substring(1) + "FF"));
    buffer.shader(metaballShader);
    line.draw(buffer);
    metaballShader.set("lineGlowIntensity", line.glowIntensity);
    metaballShader.set("lineGlowColor", 
    rgb2[0], 
    rgb2[1], 
    rgb2[2]
    );
    ///////////
    float[] arcCenters = new float[28 * 3];
    float[] arcColors = new float[28 * 3];
    float[] arcStartAngles = new float[28];
    float[] arcEndAngles = new float[28];
    float[] arcThicknesses = new float[28];
    float[] arcOpacities = new float[28];

    for (int i = 0; i < 28 && i < arcs.size(); i++) {
      ArcData arc = arcs.get(i);
      arcCenters[i * 3] = arc.x;
      arcCenters[i * 3 + 1] = arc.y;
      arcCenters[i * 3 + 2] = arc.radius;

      arcColors[i * 3] = arc.r;
      arcColors[i * 3 + 1] = arc.g;
      arcColors[i * 3 + 2] = arc.b;

      arcStartAngles[i] = arc.startAngle;
      arcEndAngles[i] = arc.endAngle;
      arcThicknesses[i] = arc.thickness;
      arcOpacities[i] = arc.a;
    }

    metaballShader.set("arcCenters", arcCenters, 3);
    metaballShader.set("arcColors", arcColors, 3);
    metaballShader.set("arcStartAngles", arcStartAngles);
    metaballShader.set("arcEndAngles", arcEndAngles);
    metaballShader.set("arcThicknesses", arcThicknesses);
    metaballShader.set("arcOpacities", arcOpacities);
    /////////////
    metaballShader.set("lineStart", line.startX, line.startY);
    metaballShader.set("lineEnd", line.endX, line.endY);
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
    buffer.endDraw();

    image(buffer, 0, 0, width, height);
  }
}
