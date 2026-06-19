// sim.ms - time machine simulator loop

import "actions"    // game actions
import "tdos"       // tdos computer
import "clock"      // dates and times

startTime = new clock.Time
firstTravelTime = new clock.Time
currentTime = new clock.Time
goalTime = new clock.Time
timeElapsed = 0
currentView = "console"
paused = true

console = function
	if debug then print "actions.console"
	tdos.sessionStart = currentTime
	tdos.run
end function

dashboard = function
	print("dashboard view not implemented yet")
end function

control = function
	print("control panel view not implemented yet")
end function

inside = function
	print("inside time machine view not implemented yet")
end function

outside = function
	print("outside time machine view not implemented yet")
end function

viewList = {
  	"console": @console,
  	"dashboard": @dashboard,
  	"control": @control,
  	"inside": @inside,
  	"outside": @outside,
}

run = function
	paused = false
	if debug then print "sim.run"
	actions.lookaway
	actions.reboot
	if debug then print "paused = " + paused
	while paused == false
		print 
		if not viewList.hasIndex(currentView) then
			print "sim.run: view not found: " + currentView 
			exit
		end if
		viewList[currentView]
	end while
end function
