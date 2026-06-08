clear
gfx.clear color.white
gfx.color = color.gray
for x in range(0, 960, 64)
	gfx.line x, 0, x, 640
	gfx.print x, x, 0
end for
for y in range (0, 640, 64)
	gfx.line 0, y, 960, y
	gfx.print y, 0, y
end for
key.get  // wait for key press
