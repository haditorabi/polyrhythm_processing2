import javax.sound.midi.*;
import java.util.HashMap;

class MidiSender {
  MidiDevice outputDevice;
  Receiver midiOut;
  private NoteMap noteMap;
  ArrayList<MidiNoteEvent> activeNotes = new ArrayList<MidiNoteEvent>();
  Piano piano;
  List<VisualNote> visualNotes;

  MidiSender(String deviceName, Piano pianoRef, List<VisualNote> visualNotesRef) {
  piano = pianoRef;
  visualNotes = visualNotesRef;
  noteMap = new NoteMap();

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
    Integer note = noteMap.getMidiNumber(noteName.toUpperCase());
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
    setVisualNoteActive(note, true);
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
      setVisualNoteActive(pitch, false);
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
  void setVisualNoteActive(int midi, boolean state) {
    for (VisualNote key : visualNotes) {
      if (key.midi == midi) {
        key.setGlowing(state);
        break;
      }
    }
  }
}
