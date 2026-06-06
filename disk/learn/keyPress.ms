print "Hold left shift to count up. Press Esc to quit."
x = 0
while not key.pressed("escape")
	if key.pressed("left shift") then
		x = x + 1
		print x
	end if
end while
key.clear