// game.ms - main tmsim game loop

difficulty = 1

init = function
	if debug then print("game.init")
	player.init
	tm.init
end function

run = function
	if debug then print("game.run")
	sim.run
end function
