import java.util.HashMap;

public class NoteMap {
  private final HashMap<String, Integer> noteMap;

  public NoteMap() {
    noteMap = new HashMap<>();
    String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};

    for (int octave = -1; octave <= 9; octave++) {
      for (int i = 0; i < notes.length; i++) {
        int midiNumber = (octave + 1) * 12 + i;
        if (midiNumber >= 21 && midiNumber <= 108) {
          noteMap.put(notes[i] + octave, midiNumber);
        }
      }
    }
  }

  public Integer getMidiNumber(String noteName) {
    return noteMap.get(noteName);
  }
  public void getAll() {
    noteMap.forEach((key, value) -> {
      System.out.println("Key: " + key + ", Value: " + value);
    }
    );
  }
}
