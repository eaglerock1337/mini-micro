import "turtle"
clear

drawBranch = function(turtle, scale = 1)
	if scale < 0.02 then return
	// create a new turtle, so we don't move the one passed in
	t = new turtle
	// draw main branch
	t.penSize = 20 * scale
	t.forward 100 * scale
	// draw sub-branches
	t.left 70
	drawBranch t, scale * 0.4
	t.right 70 * 2
	drawBranch t, scale * 0.4
	t.left 70
	drawBranch t, scale * 0.6
end function

t = new Turtle
for i in range(1, 6)
	drawBranch t
	t.left 60
end for