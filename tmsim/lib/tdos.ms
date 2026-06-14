// tdos.ms - computer emulator game loop

import "console"      // console mode with tui
import "time"					// date and time class

sessionStart = new time.Time
console = console.Console

run = function
	if debug then print("tdos.run")
	screen.useConsole
	console.reset
	screen.consoleBody.print("start date: " + sessionStart.date)
	screen.consoleBody.print("start time: " + sessionStart.time)
end function
