import java.util.HashMap;

public class NoteMap {
    // Instance HashMap to store note names and their corresponding MIDI numbers
    private HashMap<String, Integer> noteMap;

    // Instance initializer block to initialize noteMap
    {
        noteMap = new HashMap<>();
        String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
        for (int octave = 0; octave <= 8; octave++) {
            for (int i = 0; i < notes.length; i++) {
                int midiNumber = octave * 12 + i;
                if (midiNumber >= 0 && midiNumber <= 108) {
                    noteMap.put(notes[i] + octave, midiNumber);
                }
            }
        }
    }
    // Method to get the MIDI number for a given note name
    public Integer getMidiNumber(String noteName) {
        return noteMap.get(noteName);
    }
}
