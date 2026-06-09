import "mathUtil"
clear
sheet = file.loadImage("/sys/pics/Enemies.png")
// Make a subclass of Sprite called Stamper
Stamper = new Sprite
Stamper.frames = []  // (image for each frame of animation)
Stamper.frames.push sheet.getImage(0, 128*3, 128, 128)
Stamper.frames.push sheet.getImage(0, 128*2, 128, 128)
Stamper.localBounds = new Bounds
Stamper.localBounds.width = 128
Stamper.localBounds.height = 128
Stamper.target = {"x": 480, "y": 320}
Stamper.lastStepTime = 0
Stamper.curFrame = 0
Stamper.update = function
	if time > self.lastStepTime + 0.2 then
		// Change to the other image (stamp stamp!)
		self.curFrame = 1 - self.curFrame
		self.image = self.frames[self.curFrame]
		self.lastStepTime = time
	end if
	// Move towards the target
	mathUtil.moveTowardsXY self, self.target, 5
	self.sortOrder = -self.y
end function

// Create a Stamper instances, and add it to the sprite display
stampy = new Stamper  // yes, it's stampy the Stamper!
display(4).sprites.push stampy
stampy2 = new Stamper  // and he has a friend
display(4).sprites.push stampy2
stampy2.target = {"x": 800, "y": 100}

stampy.update = function
	super.update
	if self.overlaps(stampy2) then
		self.tint = color.red
	else
		self.tint = color.white
	end if
end function

// Main loop: update sprites, and set target on mouse click
while true
	for spr in display(4).sprites
		spr.update  // assumes all sprites have an update function
	end for
	// sort sprites by their sortOrder property
	display(4).sprites.sort "sortOrder"
	if mouse.button then stampy.target = mouse + {}
	yield
end while
