for layer in range(7, 0)
	// set layer to text mode with random text color
	display(layer).mode = displayMode.text
	display(layer).color = rgb(255*rnd, 255*rnd, 255*rnd)
	display(layer).clear
	// fill it with random characters
	for row in range(0, 25)
		for col in range(0, 67)
			c = char (32 + rnd*64)
			display(layer).setCell col, row, c
		end for
	end for
	wait
end for
