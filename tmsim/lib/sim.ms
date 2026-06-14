// sim.ms - time machine simulator loop

import "actions"     // game actions
import "time"				 // dates and times

startTime = new time.Time
currentTime = new time.Time
goalTime = new time.Time
timeElapsed = 0
currentView = "console"
paused = true

viewList = {
  	"console": @console,
  	"dashboard": @dashboard,
  	"control": @control,
  	"inside": @inside,
  	"outside": @outside
}

run = function
		paused = false
		if debug then print("sim.run")
		actions.test
		while paused == false
				if not viewList.hasIndex(currentView) then
					  print("sim.run: view not found: " & currentView)
						exit
				end if
		end while
end function

console = function
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