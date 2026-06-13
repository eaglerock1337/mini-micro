import "turtle"
import "mathUtil"
clamp = @mathUtil.clamp  // used often
clear

// randColor: return a random (bright) color, 155-255 in RGB.
randColor = function
	return color.fromList([155+99*rnd, 155+99*rnd, 155+99*rnd])
end function

// Step class. Draws one branch of a snowflake
// (using recursion to draw sub-branches
Step = {}

Step.newRandom = function
	result = new Step
	result.penSize = round(5 + 10 * rnd)
	result.penColor = randColor
	result.fwd = 25 + 50 * rnd
	result.sideAngle = 20 + 60 * rnd
	result.sideScale = 0.25 + 0.5 * rnd
	result.sideStepNum = floor(rnd * 4)
	result.fwdScale = 0.25 + 0.5 * rnd
	result.fwdStepNum = floor(rnd * 4)
	return result
end function

Step.draw = function(turtle, steps, scale=1)
	if scale < 0.1 then return
	t = new turtle
	t.penSize = self.penSize * scale
	t.color = self.penColor
	t.forward self.fwd * scale
	newScale = scale * self.sideScale
	if self.sideAngle > 0 and steps.hasIndex(self.sideStepNum) then
		t.left self.sideAngle
		steps[self.sideStepNum].draw t, steps, newScale
		t.right self.sideAngle * 2
		steps[self.sideStepNum].draw t, steps, newScale
		t.left self.sideAngle
	end if
	newScale = scale * self.fwdScale
	if newScale > 0 and steps.hasIndex(self.fwdStepNum) then
		steps[self.fwdStepNum].draw t, steps, newScale
	end if
end function

// Snowflake class: keeps four Steps, and uses them to
// draw a complete snowflake.
Snowflake = {}

Snowflake.newRandom = function
	result = new Snowflake
	result.steps = []
	for i in range(1, 4)
		result.steps.push Step.newRandom
	end for
	return result
end function

Snowflake.draw = function(x=480, y=320)
	t = new Turtle
	t.penDown = false
	t.goTo x, y
	t.penDown = true
	for i in range(0, 5)
		self.steps[0].draw t, self.steps
		t.left 60
	end for
end function

Step.mutate = function
	i = floor(rnd * 8)
	if i == 0 then
		self.penSize = clamp(self.penSize + rnd*2-1, 1, 15)
	else if i == 1 then
		self.fwd = clamp(self.fwd + rnd * 20 - 10, 10, 100)
	else if i == 2 then
		self.sideAngle = clamp(self.sideAngle + rnd * 20 - 10, 0, 170)
	else if i == 3 then
		self.sideScale = clamp(self.sideScale + rnd/2-0.25, 0, 0.8)
	else if i == 4 then
		self.sideStepNum = floor(rnd * 4)
	else if i == 5 then
		self.fwdScale = clamp(self.fwdScale + rnd/2-0.25, 0, 0.9)
	else if i == 6 then
		self.penColor = randColor
	else
		self.fwdStepNum = floor(rnd * 4)
	end if
end function

Step.clone = function
	return {} + self
end function

Snowflake.cloneAndMutate = function
	result = new Snowflake
	result.steps = []
	for step in self.steps
		result.steps.push step.clone
		result.steps[-1].mutate
	end for
	return result
end function

// Helper function to wait for a click. Also watches
// for the Escape key, and if pressed, exits the program.
waitForClick = function
	// wait for mouse down, or escape key
	while not mouse.button
		if key.pressed("escape") then exit
		yield
	end while
	// wait for mouse up
	while mouse.button; yield; end while
end function

// Prepare six snowflakes.
flakes = []
for i in range(0, 5)
	flakes.push Snowflake.newRandom
end for

// Main loop.
while true
	// Draw our current six snowflakes.
	clear
	for i in range(0, 5)
		col = i % 3
		row = floor(i / 3)
		flakes[i].draw 160 + col * 320, 160 + row * 320
	end for
	
	// Wait for a click, and figure out which flake was hit.
	waitForClick
	col = floor(mouse.x / 320)
	row = floor(mouse.y / 320)
	choice = row * 3 + col
	
	// Replace all the other flakes with new ones.
	for i in range(0, 5)
		if i != choice then
			// create either a mutant of the chosen one,
			// or occasionally, a completely new one
			if rnd < 0.8 then
				flakes[i] = flakes[choice].cloneAndMutate
			else
				flakes[i] = Snowflake.newRandom
			end if
		end if
	end for
end while