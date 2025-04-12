class MidiNoteEvent {
  int note;
  int velocity;
  int channel;
  long offTimeMillis;

  MidiNoteEvent(int note, int velocity, int channel, int durationMillisec) {
    this.note = note;
    this.velocity = velocity;
    this.channel = channel;
    this.offTimeMillis = millis() + durationMillisec;
  }
}
