// tdos.ms - computer emulator game loop

import "console"      // console mode with tui
import "time"					// date and time class

sessionStart = new time.Time
console = console.Console

run = function
	if debug then print("tdos.run")
	console.reset
	print("start date: " + sessionStart.date)
	print("start time: " + sessionStart.time)
end function
