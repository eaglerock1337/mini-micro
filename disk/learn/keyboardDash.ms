print "Keyboard Dash!"
print "Press the , and . keys as fast as you can"
print "to race to the finish line."
print
print "Ready..."; wait
print "Set..."; wait
print "GO!"

lastKey = ""
count = 0
startTime = time
while count < 25
	k = key.get
	if k == lastKey then continue
	if k != "." and k != "," then continue
	count = count + 1
	print count
end while
elapsed = time - startTime
print "DONE!"
print "You finished in " + elapsed + " seconds. Great job!"