// sim.ms - time machine simulator loop

import "actions"     // game actions
import "time"				 // dates and times

startTime = new time.Time
currentTime = new time.Time
goalTime = new time.Time
timeElapsed = 0

run = function
	if debug then print("sim.run")
	actions.test
	tdos.sessionStart = currentTime
	tdos.run
end function
