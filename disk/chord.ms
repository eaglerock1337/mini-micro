notes = []
freqs = [220, 275, 330, 440]
dur = 1
env = 1
wave = Sound.squareWave

for freq in freqs
	snd = new Sound
	snd.init dur, freq, env, wave
	notes.push snd
end for

for note in notes
	note.play
	wait note.duration
end for

chord = notes[0]
chord.mix notes[1]
chord.mix notes[2]
chord.mix notes[3]

chord.play