// player.ms - player singleton

import "stats"

health = 100

stats = new stats.Stats

init = function
	if debug then print("player.init")
end function
