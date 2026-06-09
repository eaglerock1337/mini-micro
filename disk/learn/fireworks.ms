// set up
import "listUtil"
clear
gfx.clear color.clear, 960/3, 640/3
gfx.scale = 3

display(2).mode = displayMode.pixel
flashGfx = display(2)
flashGfx.clear color.clear, gfx.width, gfx.height
flashGfx.scale = gfx.scale
flashGfx.color = color.white

display(7).mode = displayMode.pixel
bkgnd = display(7)
bkgnd.clear color.black, gfx.width, gfx.height
bkgnd.scale = gfx.scale
for y in range(0, bkgnd.height-1)
	c = color.lerp("#550055", "#000022", y/bkgnd.height)
	bkgnd.line 0, y, bkgnd.width, y, c
end for

burstColors = [color.yellow, color.red, color.blue,
               color.aqua, color.pink, color.lime, color.fuchsia]

launchSnd = new Sound
launchSnd.init 0.3, 5, [0,1,0], Sound.noiseWave

burstSnd = new Sound
burstSnd.init 1, 2, [1, 0.1, 0.01, 0], Sound.noiseWave

panForX = function(x)
	return 2 * (x / gfx.width - 0.5)
end function

// make a Particle class
Particle = {}
Particle.x = 0
Particle.y = 0
Particle.vx = 0
Particle.vy = 0
Particle.color = color.yellow
Particle.trail = null
Particle.maxTrails = 5
Particle.gravity = -15
Particle.dragFactor = 0.99
Particle.update = function(dt=0.1)
	// apply gravity and drag to velocity
	self.vy = (self.vy + self.gravity * dt) * self.dragFactor
	self.vx = self.vx * self.dragFactor
	
	// apply velocity to position
	self.x = self.x + self.vx * dt
	self.y = self.y + self.vy * dt
	
	// draw, appending to the trail
	gfx.setPixel self.x, self.y, self.color
	if self.trail == null then self.trail = []
	self.trail.push [self.x, self.y]
	
	// erase when the trail is too long
	if self.trail.len == self.maxTrails then
		pos = self.trail.pull
		gfx.setPixel pos[0], pos[1], color.clear
	end if
end function
Particle.die = function
	// erase trail
	for pos in self.trail
		gfx.setPixel pos[0], pos[1], color.clear
	end for
	// remove from global list
	particles.removeVal self  // removeVal is from listUtil
end function

// keep a list of all Particle instances
particles = []

// make a subclass of Particle that represents a rocket
Rocket = new Particle
Rocket.timeTillBurst = 3
Rocket.update = function(dt=0.1)
	// do standard particle update...
	super.update dt
	
	// then, update time till burst, and burst when it's time
	self.timeTillBurst = self.timeTillBurst - dt
	if self.timeTillBurst < 0 then
		// remove the rocket particle and its tail
		self.die
		
		// create the burst particles
		c = burstColors.any  // (.any provided by listUtil)
		for i in range(1, 40)
			p = new Ember
			p.startColor = c
			p.maxAge = rnd * 5 + 3
			p.x = self.x
			p.y = self.y
			angle = 2 * pi * rnd
			speed = 10 + 50 * rnd
			p.vx = speed * cos(angle)
			p.vy = speed * sin(angle)
			particles.push p
		end for
		
		// flash and bang
		flashGfx.fillEllipse self.x-10, self.y-10, 20, 20
		globals.haveFlash = true
		burstSnd.play 1, panForX(self.x), 0.9 + 0.2 * rnd
	end if
end function

// make another Particle subclass that represents the
// embers that float down after the rocket bursts
Ember = new Particle
Ember.age = 0
Ember.maxAge = 3
Ember.gravity = -5
Ember.dragFactor = 0.90
Ember.startColor = color.pink
Ember.endColor = "#88000088"  // translucent red
Ember.update = function(dt=0.1)
	// age, adjust our color, and when it's time, die
	self.age = self.age + dt
	if self.age > self.maxAge then
		self.die
	else
		// update our color
		self.color = color.lerp(self.startColor, self.endColor, self.age/3)
		// and then do standard particle update
		super.update dt
	end if
end function


// function to create and launch a new firework
launchAt = function(x)
	p = new Rocket
	p.x = x / gfx.scale
	p.y = 0
	p.vx = 30 * rnd - 15
	p.vy = 10 * rnd + 80
	p.timeTillBurst = 3 + 3 * rnd
	particles.push p
	launchSnd.play 0.3, panForX(p.x), 0.9 + 0.2 * rnd
end function

// main loop
mouseWasDown = false
haveFlash = false
while true
	// clear the flashes, if we have any
	if haveFlash then
		flashGfx.fillRect 0, 0, flashGfx.width,
		  flashGfx.height, color.clear
		globals.haveFlash = false
	end if
	// launch whenever the mouse is clicked
	mouseIsDown = mouse.button
	if mouseIsDown and not mouseWasDown then
		launchAt mouse.x; launchAt mouse.x
	end if
	mouseWasDown = mouseIsDown
	// update all particles
	for p in particles
		p.update
	end for
	yield
end while