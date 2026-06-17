// game.ms - Main tmsim module
// Manages tmsim state and the main loop.

import "TimeMachine"

tmsim = {}

tmsim.timeMachine = null

tmsim.init = function
	clear
	text.color = color.lime
	print "=== TIME MACHINE SIMULATOR ==="
	print

	self.timeMachine = new TimeMachine.TimeMachine
	self.timeMachine.init "DeLorean", 2026

	print "Time machine initialized: " + self.timeMachine.toString
	print
end function

tmsim.run = function
	self.init

	while true
		text.color = color.white
		print "Commands: [t]arget year, [c]harge, [a]ccelerate, [g]o!, [q]uit"
		inp = input("> ").lower

		if inp == "q" then
			print "Goodbye!"
			break
		else if inp == "t" then
			year = input("Enter target year: ").val
			if year != 0 then self.timeMachine.setTarget year
		else if inp == "c" then
			self.timeMachine.chargeFluxCapacitor
		else if inp == "a" then
			self.timeMachine.accelerate 10
			print "Speed: " + self.timeMachine.speed + " mph"
		else if inp == "g" then
			self.timeMachine.travel
		else
			print "Unknown command."
		end if

		print
		print self.timeMachine.toString
		print "---"
	end while
end function
