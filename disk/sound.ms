s = new Sound
s.freq = 220
s.envelope = 1
s.duration = 1

waves = [Sound.sineWave, Sound.triangleWave, Sound.squareWave, Sound.sawtoothWave]

for wave in waves
	s.waveform = wave
	s.play
	wait 1.25
end for	

s.freq = 880
s.play