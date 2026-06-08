clear
gfx.color = color.white
prev = {}

printAt = function(row, col, s)
	text.row = row
	text.column = col
	text.delimiter = ""
	print s
	text.delimiter = char(13)
end function

while not key.pressed("escape")
	// The mouse might move within this loop so let's grab a copy
	// of it right away as "m" and use only that.
	m = {"x": mouse.x, "y": mouse.y}
	
	// If the button is down, draw a line from our prev position
	if mouse.button then gfx.line prev.x, prev.y, m.x, m.y
	
	printAt 25, 0, "Prev: " + prev
	printAt 24, 0, "Curr: " + m
	prev = m
	yield
end while
key.clear
