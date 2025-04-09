class ThemeUtils {
  public float[] hexToRGB(String hex) {
    float[] rgb = new float[3];
    rgb[0] = unhex(hex.substring(1, 3)) / 255.0;
    rgb[1] = unhex(hex.substring(3, 5)) / 255.0;
    rgb[2] = unhex(hex.substring(5, 7)) / 255.0;
    return rgb;
  }
}
