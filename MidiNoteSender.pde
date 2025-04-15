import javax.sound.midi.*;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.List;

public class MidiNoteSender {
  private MidiDevice outputDevice;
  private Receiver midiOut;
  private NoteMap noteMap;
  private final List<MidiNoteEvent> activeNotes = new ArrayList<>();
  private final List<NoteListener> listeners = new ArrayList<>();
  private final GuidelineToTop centerLine;

  public MidiNoteSender(String deviceName, NoteMap noteMapArg, GuidelineToTop centerLine) {
    this.noteMap = noteMapArg;
    this.outputDevice = connectToDevice(deviceName);
    this.centerLine = centerLine;
  }

  private MidiDevice connectToDevice(String deviceName) {
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
    }
    catch (Exception e) {
      println("❌ MIDI init failed:");
      e.printStackTrace();
    }
    return outputDevice;
  }

  public void sendNote(String noteName, int velocity, int durationMillis) {
    Integer note = noteMap.getMidiNumber(noteName.toUpperCase());
    if (note != null) {
      sendNote(note, velocity, durationMillis, 0);
    } else {
      println("⚠️ Invalid note name: " + noteName);
    }
  }

  public void sendNote(int note, int velocity, int durationMillis, int channel) {
    if (!isNoteAlreadyActive(note)) {
      sendNoteOn(channel, note, velocity);
      activeNotes.add(new MidiNoteEvent(note, velocity, channel, durationMillis));
      notifyListeners(note, true);
      centerLine.onNoteHitLine();
    }
  }

  public void sendNote(String noteName, int velocity, int durationMillis, int channel) {
    Integer note = noteMap.getMidiNumber(noteName.toUpperCase());
    if (note != null) {
      sendNote(note, velocity, durationMillis, channel);
    } else {
      println("⚠️ Invalid note name: " + noteName);
    }
  }

  private void sendNoteOn(int channel, int pitch, int velocity) {
    try {
      ShortMessage msg = new ShortMessage();
      msg.setMessage(ShortMessage.NOTE_ON, channel, pitch, velocity);
      midiOut.send(msg, -1);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  private void sendNoteOff(int channel, int pitch, int velocity) {
    try {
      ShortMessage msg = new ShortMessage();
      msg.setMessage(ShortMessage.NOTE_OFF, channel, pitch, velocity);
      midiOut.send(msg, -1);
    }
    catch (Exception e) {
      e.printStackTrace();
    }
    notifyListeners(pitch, false);
  }

  public void update() {
    long now = millis();
    for (int i = activeNotes.size() - 1; i >= 0; i--) {
      MidiNoteEvent e = activeNotes.get(i);
      if (now >= e.offTimeMillis) {
        sendNoteOff(e.channel, e.note, e.velocity); // Use stored channel!
        activeNotes.remove(i);
      }
    }
  }


  public void addNoteListener(NoteListener listener) {
    listeners.add(listener);
  }

  public void removeNoteListener(NoteListener listener) {
    listeners.remove(listener);
  }

  private void notifyListeners(int midi, boolean on) {
    for (NoteListener listener : listeners) {
      listener.onNoteStateChanged(midi, on);
    }
  }

  public void close() {
    if (outputDevice != null && outputDevice.isOpen()) {
      outputDevice.close();
    }
  }
  private boolean isNoteAlreadyActive(int note) {
    for (MidiNoteEvent e : activeNotes) {
      if (e.note == note) {
        return true;
      }
    }
    return false;
  }
}
