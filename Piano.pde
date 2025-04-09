class Piano {
  ArrayList<PianoKey> pianoKeys;

  Piano() {
    pianoKeys = new ArrayList<PianoKey>();
    buildPiano();
  }

  void buildPiano() {
    float whiteKeyWidth = width / 52.0;
    float blackKeyWidth = whiteKeyWidth * 0.6;
    float whiteKeyHeight = 120;
    float blackKeyHeight = 80;

    int whiteIndex = 0;
    for (int midi = 21; midi <= 108; midi++) {
      String noteName = getNoteName(midi);
      boolean isBlack = noteName.contains("#");

      if (!isBlack) {
        float x = whiteIndex * whiteKeyWidth;
        pianoKeys.add(new PianoKey(midi, false, x, height - whiteKeyHeight, whiteKeyWidth, whiteKeyHeight));
        whiteIndex++;
      }
    }

    whiteIndex = 0;
    for (int midi = 21; midi <= 108; midi++) {
      String noteName = getNoteName(midi);
      boolean isBlack = noteName.contains("#");

      if (isBlack) {
        // Find left and right white keys
        PianoKey left = getWhiteKeyBefore(midi);
        PianoKey right = getWhiteKeyAfter(midi);

        if (left != null && right != null) {
          float x = (left.x + right.x + left.w) / 2 - blackKeyWidth / 2;
          pianoKeys.add(new PianoKey(midi, true, x, height - whiteKeyHeight, blackKeyWidth, blackKeyHeight));
        }
      }
    }
  }

  PianoKey getWhiteKeyBefore(int midi) {
    for (int i = midi - 1; i >= 21; i--) {
      if (!getNoteName(i).contains("#")) {
        for (PianoKey key : pianoKeys) {
          if (key.midi == i && !key.isBlack) return key;
        }
      }
    }
    return null;
  }

  PianoKey getWhiteKeyAfter(int midi) {
    for (int i = midi + 1; i <= 108; i++) {
      if (!getNoteName(i).contains("#")) {
        for (PianoKey key : pianoKeys) {
          if (key.midi == i && !key.isBlack) return key;
        }
      }
    }
    return null;
  }

  String getNoteName(int midi) {
    String[] names = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
    int index = midi % 12;
    return names[index];
  }

  void draw(PGraphics shaderBuffer) {
    // Draw white keys first
    for (PianoKey key : pianoKeys) {
      if (!key.isBlack) key.display(shaderBuffer);
    }
    // Then draw black keys over them
    for (PianoKey key : pianoKeys) {
      if (key.isBlack) key.display(shaderBuffer);
    }
  }

  // Call this externally from MidiSender or NoteSpiral
  void setKeyActive(int midi, boolean active) {
    for (PianoKey key : pianoKeys) {
      if (key.midi == midi) {
        key.setActive(active);
        break;
      }
    }
  }
}
