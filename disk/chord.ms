notes = []
freq = 220
ratios = [1, 5/4, 1.5, 2]
dur = 1
env = 1
wave = Sound.squareWave

for ratio in ratios
	iep = new Sound
	iep.init dur, freq * ratio, env, wave
	notes.push iep
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