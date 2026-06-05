// Sea Battle
print "Welcome to SEA BATTLE!"
print

rows = "987654321".split("")
cols = "ABCDEFGHIJK".split("")

shipTypes = {
  "Battleship": "BBBBB",
  "Destroyer": "DDDD",
  "Cruiser": "CCC",
  "Frigate": "FFF",
  "Patrol Boat": "PP" }

EMPTY = "."
MISS = "w"
HIT = "*"

newMap = function()
	m = {}
	for r in rows
		for c in cols
			m[c + r] = EMPTY
		end for
	end for
	return m
end function

isRow = function(s)
	return rows.indexOf(s) != null
end function
isCol = function(s)
	return cols.indexOf(s) != null
end function

// Get coordinates from the user and return the string in
// standard form, e.g. "A1" (to index into one of our sea maps).
inputCoordinates = function(prompt)
	while true
		s = input(prompt).upper
		if s.len == 2 and isRow(s[0]) and isCol(s[1]) then
			return s[1] + s[0]
		else if s.len == 2 and isRow(s[1]) and isCol(s[0]) then
			return s
		end if
		print "Please enter a map position like A1 or G8."
	end while
end function

Player = {}

Player.init = function()
	self.myMap = newMap
	self.targetMap = newMap
	self.shipsLeft = []  // names of ships not yet sunk
end function

Player.print = function()
	print "  YOUR SHIPS         TARGET MAP"
	print " +-----------+     +-----------+"
	for r in rows
		temp = [r, "|"]
		for c in cols
			temp.push self.myMap[c + r]
		end for
		temp.push "|    " + r + "|"
		for c in cols
			temp.push self.targetMap[c + r]
		end for
		temp.push "|"
		print temp.join("")
	end for
	print " +-----------+     +-----------+"
	print "  " + cols.join("") + "       " + cols.join("")
end function

// Write a string representing a ship into our map, or optionally,
// just check whether we COULD write such a string. Return an
// error string if it runs out of bounds or hits another ship;
// or if everything is OK, then return null.
Player.writeToMap = function(ship, position, horizontal, checkOnly)
	c = position[0]  // column, e.g. "E"
	r = position[1]  // row, e.g. "5"
	for i in ship.indexes
		// check and maybe write to the map
		if self.myMap[c + r] != EMPTY then return "Position Blocked"
		if not checkOnly then self.myMap[c + r] = ship[i]
		
		// then, advance to the next position (unless we're done)
		if i == ship.len-1 then return
		if horizontal then
			idx = cols.indexOf(c) + 1
			if idx >= cols.len then return "Out of bounds"
			c = cols[idx]
		else
			idx = rows.indexOf(r) + 1
			if idx >= rows.len then return "Out of bounds"
			r = rows[rows.indexOf(r) + 1]
		end if
	end for
end function

Player.placeShipByInput = function(name)
	self.print
	print
	self.shipsLeft.push name
	ship = shipTypes[name]
	while true  // keep trying till we succeed
		print "Placing " + name + " (size " + ship.len + ")."
		pos = inputCoordinates("  Top-left coordinates? ")
		hv = ""
		while hv != "H" and hv != "V"
			hv = input("  Horizontal or Vertical (H/V)? ").upper
		end while
		err = self.writeToMap(ship, pos, hv=="H", true)  // just check
		if err then
			print err + ".  Please try again!"
		else
			self.writeToMap ship, pos, hv == "H", false  // place ship
			return
		end if
	end while
end function

Player.placeShipRandomly = function(name)
	self.shipsLeft.push name
	ship = shipTypes[name]
	while true  // keep trying till we succeed
		pos = cols[rnd * cols.len] + rows[rnd * rows.len]
		horizontal = (rnd < 0.5)
		err = self.writeToMap(ship, pos, horizontal, true)  // check
		if err then continue
		self.writeToMap ship, pos, horizontal, false  // place ship
		return
	end while
end function

// Fire at the other player's map.
// Print HIT or MISS, and return the name of the ship sunk (if any)
Player.fire = function(pos, otherPlayer)
	if otherPlayer.myMap[pos] == EMPTY or otherPlayer.myMap[pos] == MISS then
		print "Miss!"
		otherPlayer.myMap[pos] = MISS
		self.targetMap[pos] = MISS
	else
		print "HIT!"
		wait
		otherPlayer.myMap[pos] = HIT
		self.targetMap[pos] = HIT
		// Check for a ship that's been sunk.
		// Every ship has a unique letter, so we know it's sunken if
		// that letter is not found anywhere in the map.
		for name in otherPlayer.shipsLeft
			if otherPlayer.myMap.indexOf(name[0]) == null then
				// This ship is not found, so it has been sunk.
				otherPlayer.shipsLeft.remove otherPlayer.shipsLeft.indexOf(name)
				return name
			end if
		end for
	end if
end function

// Here is the "AI" of the game, that is, the code that decides
// what to do on the computer's turn.
ai = function()
	while true  // repeat until we find spot we haven't tried
		r = rows[rnd * rows.len]
		c = cols[rnd * cols.len]
		if comp.targetMap[c + r] == EMPTY then break
	end while
	print "I fire at " + c + r + "..."
	sunk = comp.fire(c + r, human)
	if sunk then print "Ha ha! I sunk your " + sunk + "!"
end function

// Set up the human player
human = new Player
human.init
for s in shipTypes.indexes
	human.placeShipByInput s  // (or placeShipRandomly to speed things up)
end for
human.print

// Now set up the computer player
comp = new Player
comp.init
for s in shipTypes.indexes
	comp.placeShipRandomly s
end for
//comp.print  // <-- Just for debugging.  (No cheating!)

// Main game loop
while true
	print
	sunk = human.fire(inputCoordinates("Fire at coordinates: "), comp)
	if sunk then print "You sunk my " + sunk + "!"
	if not comp.shipsLeft then
		print "You win. Good game!"
		exit
	end if
	print
	ai
	ai  // (a second time, to make the game more challenging)
	print
	human.print
	if not human.shipsLeft then
		print "I win! Thanks for the game."
		exit
	end if
end while