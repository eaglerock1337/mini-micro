// TimeMachine.ms - The core time machine class

Vehicle = {}
Vehicle.speed = 0
Vehicle.maxSpeed = 200

Vehicle.accelerate = function(amount)
	self.speed += amount
	if self.speed > self.maxSpeed then self.speed = self.maxSpeed
	if self.speed < 0 then self.speed = 0
end function

TimeMachine = new Vehicle
TimeMachine.name = "DeLorean"
TimeMachine.currentYear = 2026
TimeMachine.targetYear = 2026
TimeMachine.fluxCapacitorCharged = false

TimeMachine.init = function(name, startYear)
	self.name = name
	self.currentYear = startYear
	self.targetYear = startYear
	self.fluxCapacitorCharged = false
	self.speed = 0
	return self
end function

TimeMachine.setTarget = function(year)
	self.targetYear = year
	text.color = color.aqua
	print self.name + " target set to year " + year
end function

TimeMachine.chargeFluxCapacitor = function
	self.fluxCapacitorCharged = true
	text.color = color.yellow
	print "Flux capacitor charged!"
end function

TimeMachine.travel = function
	if not self.fluxCapacitorCharged then
		text.color = color.red
		print "ERROR: Flux capacitor not charged!"
		return false
	end if
	if self.speed < 88 then
		text.color = color.red
		print "ERROR: Need 88 mph! Currently at " + self.speed + " mph."
		return false
	end if
	text.color = color.lime
	print "Traveling from " + self.currentYear + " to " + self.targetYear + "..."
	self.currentYear = self.targetYear
	self.fluxCapacitorCharged = false
	self.speed = 0
	print "Arrived in " + self.currentYear + "!"
	return true
end function

TimeMachine.toString = function
	charged = "NO"
	if self.fluxCapacitorCharged then charged = "YES"
	return self.name + " | Year: " + self.currentYear + " | Target: " + self.targetYear + " | Speed: " + self.speed + " mph | Flux: " + charged
end function
