public class ThemeProvider {
  public Theme getRandomTheme() {
    return new ThemeLibrary().getRandom();
  }
}
