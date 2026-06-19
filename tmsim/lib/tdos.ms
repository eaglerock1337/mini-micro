// tdos.ms - computer emulator game loop

import "commands"   // tdos command list
import "console"    // console mode with tui
import "screen"     // mini micro displays
import "time"       // date and time class

sessionStart = new time.Time
console = console.Console

run = function
	active = true
	if debug then print "tdos.run"
	screen.useConsole
	console.reset

	while active
		command = console.prompt
		if commands.map.hasIndex(command) then
			commands.run(command)
		end if
	end while
end function
