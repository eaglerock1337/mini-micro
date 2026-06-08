while true
	c = color.rgb(255*rnd, 255*rnd, 255*rnd)
	pen = 1 + rnd*20
	gfx.line 960*rnd, 640*rnd, 960*rnd, 640*rnd, c, pen
	wait 0.05
end while
