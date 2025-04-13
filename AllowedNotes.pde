import java.util.*;

public class AllowedNotes {
  private final List<String> allowedNames;
  private final NoteMap noteMap;
  private final String[] chromatic = {
    "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"
  };


  public AllowedNotes() {
    allowedNames = new ArrayList<>();
    noteMap = new NoteMap();
    // add("A0", "B0");
    // add("C1", "B1");
    // add("C2", "B2");
    add("C3", "B3");
    add("C4", "B4");
    add("C5", "B5");
    add("C6", "B6");
    // add("C7", "B7");
    //add("C8");
   }

  private void add(String from, String to) {
    int fromMidi = noteMap.getMidiNumber(from);
    int toMidi = noteMap.getMidiNumber(to);
    for (int midi = fromMidi; midi <= toMidi; midi++) {
      String noteName = chromatic[midi % 12] + ((midi / 12) - 1);
      if (!noteName.contains("#")) {
        allowedNames.add(noteName);
      }
    }
  }

  private void add(String singleNote) {
    allowedNames.add(singleNote);
  }

  public List<VisualNote> getVisualNotes() {
    List<VisualNote> notes = new ArrayList<>();
    for (String name : allowedNames) {
      Integer midi = noteMap.getMidiNumber(name);
      if (midi != null) {
        notes.add(new VisualNote(name, midi));
      }
    }

    notes.sort(Comparator.comparingInt(n -> n.midi));
    return notes;
  }

  public List<String> getNoteNames() {
    return allowedNames;
  }

  public List<Integer> getMidiNumbers() {
    return allowedNames.stream()
      .map(noteMap::getMidiNumber)
      .filter(Objects::nonNull)
      .toList();
  }
}
