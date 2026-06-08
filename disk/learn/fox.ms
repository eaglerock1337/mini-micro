gfx.clear
while true
	x = 960 * rnd
	y = 640 * rnd
	c = gfx.pixel(x, y)[:7]  // ignore alpha
	if c == color.black then
		gfx.setPixel x, y, color.gray
	else
		gfx.setPixel x, y, color.aqua
	end if
end while
