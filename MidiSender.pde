import javax.sound.midi.*;
import java.util.HashMap;

class MidiSender {
  MidiDevice outputDevice;
  Receiver midiOut;
  HashMap<String, Integer> noteMap;
  ArrayList<MidiNoteEvent> activeNotes = new ArrayList<MidiNoteEvent>();
  Piano piano;
  MidiSender(String deviceName, Piano pianoRef) {
    piano = pianoRef;
    initNoteMap();  // build the note map first

    try {
      MidiDevice.Info[] infos = MidiSystem.getMidiDeviceInfo();

      for (MidiDevice.Info info : infos) {
        if (info.getName().contains(deviceName)) {
          outputDevice = MidiSystem.getMidiDevice(info);
          outputDevice.open();
          midiOut = outputDevice.getReceiver();
          println("✅ MIDI connected to: " + info.getName());
          break;
        }
      }

      if (midiOut == null) {
        println("⚠️ Could not find or open device: " + deviceName);
      }
    } catch (Exception e) {
      println("❌ MIDI init failed:");
      e.printStackTrace();
    }
  }

  // 🎵 New method for note names like "C4", "G#3", etc.
  void sendNote(String noteName, int velocity, int durationMillis) {
    Integer note = noteMap.get(noteName.toUpperCase());
    if (note != null) {
      sendNote(note, velocity, durationMillis);
    } else {
      println("⚠️ Invalid note name: " + noteName);
    }
  }

  // Existing method for MIDI number
  void sendNote(int note, int velocity, int durationMillis) {
    sendNoteOn(0, note, velocity);
    activeNotes.add(new MidiNoteEvent(note, velocity, 0, durationMillis));
    if (piano != null) piano.setKeyActive(note, true);
  }

  void sendNoteOn(int channel, int pitch, int velocity) {
    try {
      ShortMessage msg = new ShortMessage();
      msg.setMessage(ShortMessage.NOTE_ON, channel, pitch, velocity);
      midiOut.send(msg, -1);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  void sendNoteOff(int channel, int pitch, int velocity) {
    try {
      ShortMessage msg = new ShortMessage();
      msg.setMessage(ShortMessage.NOTE_OFF, channel, pitch, velocity);
      midiOut.send(msg, -1);
      if (piano != null) piano.setKeyActive(pitch, false);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
  void update() {
    long now = millis();
    for (int i = activeNotes.size() - 1; i >= 0; i--) {
      MidiNoteEvent e = activeNotes.get(i);
      if (now >= e.offTimeMillis) {
        sendNoteOff(e.channel, e.note, e.velocity);
        activeNotes.remove(i);
      }
    }
  }

  void close() {
    try {
      if (outputDevice != null && outputDevice.isOpen()) {
        outputDevice.close();
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  // 🎼 Note name → MIDI map generator
  void initNoteMap() {
    noteMap = new HashMap<String, Integer>();
    String[] notes = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    for (int octave = 0; octave <= 8; octave++) {
      for (int i = 0; i < notes.length; i++) {
        int midiNumber = octave * 12 + i;
        if (midiNumber >= 12 && midiNumber <= 108) {
          noteMap.put(notes[i] + octave, midiNumber);
        }
      }
    }
  }
}
