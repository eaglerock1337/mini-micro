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

p = new Player
p.init
p.writeToMap "DDDD", "C4", true, false
result = p.writeToMap("CCCCC", "F5", false, true)
print result
if result == null then
	p.writeToMap "CCCCC", "F5", false, false
end if
p.print