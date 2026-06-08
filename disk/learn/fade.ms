// fade a black curtain from alpha0 to alpha1
// (0 = clear, 1 = solid black) over 'duration' seconds

fade = function(alpha0, alpha1, duration=1)
	// set frontmost display to solid color
	display(0).mode = displayMode.solidColor
	t0 = time  // note the time
	while true  // loop till done
		t = (time - t0) / duration  // fraction done
		if t > 1 then break
		a = alpha0 + (alpha1 - alpha0) * t
		display(0).color = color.rgba(0, 0, 0, a)
		yield
	end while
	display(0).color = color.rgba(0, 0, 0, alpha1)
end function

// fade to black over 'duration' seconds
fadeOut = function(duration=1)
	fade 0, 255, duration
end function

// fade from black to clear over 'duration' seconds
fadeIn = function(duration=1)
	fade 255, 0, duration
	display(0).mode = displayMode.off
end function
