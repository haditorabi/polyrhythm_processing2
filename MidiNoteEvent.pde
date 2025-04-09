class MidiNoteEvent {
  int note;
  int velocity;
  int channel;
  long offTimeMillis;

  MidiNoteEvent(int note, int velocity, int channel, int durationMillis) {
    this.note = note;
    this.velocity = velocity;
    this.channel = channel;
    this.offTimeMillis = millis() + durationMillis;
  }
}
