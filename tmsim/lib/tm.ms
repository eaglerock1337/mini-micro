// tm.ms - time machine singleton

import "parts"

energy = 0

init = function
	if debug then print("tm.init")
	energy = 0
end function
