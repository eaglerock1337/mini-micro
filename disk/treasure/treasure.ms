// Treasure Hunt!
// A Minesweeper-type game with treasures.

import "listUtil"

// Constants
kCols = 20
kRows = 15
kCellGrass = 16
kCellFlag = 17
kCellBomb = 18
kCellTreasure = 10       // first treasure on sand background
kCellTransTreasure = 26  // first transparent treasure

// Set up the displays
clear
display(4).mode = displayMode.tile
td = display(4)
td.tileSet = file.loadImage("TreasureHunt.png")
td.tileSetTileSize = 32
td.cellSize = 32
td.extent = [kCols, kRows]
td.clear kCellGrass
td.scrollX = -80; td.scrollY = -80

gold = "#FFDD52FF"
gfx.color = gold
gfx.print "Treasures Found", 780, 540, gold, "small"
gfx.line 780-4, 540-4, 780 + "Treasures Found".len * 9 + 4, 540-4
treasureListY = 540 - 48
treasureListX = 780

text.color = gold
text.row = 25; print "TREASURE HUNT!"
score = 0
treasuresLeft = 0

// Load sounds
treasureSnd = file.loadSound("/sys/sounds/cha-ching.wav")
bombSnd = file.loadSound("/sys/sounds/airburst.wav")

// Define a GridPos class to represent a grid
// position (i.e. column, row).
GridPos = {"col": 0, "row": 0}

// Function to make a GridPos at a given column and row
GridPos.make = function(c, r)
	gp = new GridPos
	gp.col = c
	gp.row = r
	return gp
end function

// Function to make a random (but in-bounds) GridPos.
GridPos.random = function
	return GridPos.make(floor(kCols * rnd), floor(kRows * rnd))
end function

// Function to find the GridPos at a screen position;
// returns null if out of bounds.
GridPos.atXY = function(screenPos)
	col = floor((screenPos.x + td.scrollX) / td.cellSize)
	row = floor((screenPos.y + td.scrollY) / td.cellSize)
	if col < 0 or col >= kCols then return null
	if row < 0 or row >= kRows then return null
	return GridPos.make(col, row)
end function

// Method to get all in-bounds neighbors of this GridPos
GridPos.neighbors = function
	result = []
	for i in range(-1, 1)
		for j in range(-1, 1)
			if i == 0 and j == 0 then continue
			p = GridPos.make(self.col + i, self.row + j)
			if p.col < 0 or p.col >= kCols then continue
			if p.row < 0 or p.row >= kRows then continue
			result.push p
		end for
	end for
	return result
end function

// Method to get the tile cell through this GridPos
GridPos.cell = function
	return td.cell(self.col, self.row)
end function

handleClick = function(btn = 0)
	hitPos = GridPos.atXY(mouse)
	if hitPos == null or hitPos.cell < kCellGrass then
		// invalid click; just wait for mouse-up and return
		while mouse.button(btn); yield; end while
		return
	end if
	// valid click: highlight until mouse-up
	while mouse.button(btn)
		inCell = (GridPos.atXY(mouse) == hitPos)
		if inCell then
			td.setCellTint hitPos.col, hitPos.row, "#DDDDDD"
		else
			td.setCellTint hitPos.col, hitPos.row, color.white
		end if
		yield
	end while
	// if mouse was not released in the hit cell, bail out
	if not inCell then return
	td.setCellTint hitPos.col, hitPos.row, color.white
	// otherwise, process the click.
	// left click (btn 0), reveal the cell
	// right click (btn 1), toggle flag
	if btn == 0 then
		reveal hitPos
	else
		if hitPos.cell == kCellFlag then
			td.setCell hitPos.col, hitPos.row, kCellGrass
		else
			td.setCell hitPos.col, hitPos.row, kCellFlag
		end if
	end if
end function

// Function to draw the score and time.
drawTimeAndScore = function
	minutes = floor(time/60)
	seconds = ("00" + (floor(time) % 60))[-2:]
	s = "Time: " + minutes + ":" + seconds
	s = s + " " * 6 + "Score: " + ("000000" + score)[-6:]
	text.row = 25; text.column = 38
	print s
end function
drawTimeAndScore

// Our map of where stuff is hidden. This is stored as a 2D
// list, indexed by column, row, with values of 0,
// kCellBomb, or kCellTreasure through kCellTreasure+5.
hidden = list.init2d(kCols, kRows, 0)

// Find an empty (grass) spot in the hidden map.
findEmptyPos = function
	while true
		p = GridPos.random
		if hidden[p.col][p.row] == 0 then return p
	end while
end function

// Populate the hidden map with bombs and treasures.
buryStuff = function(qtyBombs = 40, qtyTreasures = 6)
	for i in range(1, qtyBombs)
		p = findEmptyPos
		hidden[p.col][p.row] = kCellBomb
	end for
	for i in range(1, qtyTreasures)
		p = findEmptyPos
		hidden[p.col][p.row] = kCellTreasure + (i % 6)
	end for
	globals.treasuresLeft = qtyTreasures
end function

// Show an explosion at the given grid position; end the game.
doBoom = function(p)
	bombSnd.play
	for i in range(0, 3)
		td.setCell p.col, p.row, kCellBomb+1
		wait 0.1
	end for
	for c in range(0, kCols - 1)
		for r in range(0, kRows - 1)
			if hidden[c][r] == kCellBomb then
				td.setCell c, r, kCellBomb
			end if
		end for
	end for
	td.setCell p.col, p.row, kCellBomb + 2
	text.row = 1
	print "Play again (Y/N)?"
	if key.get.upper == "N" then exit
	run
end function

gameWon = function
	text.row = 2; text.column = 30
	print "YOU WIN!"
	print "Play again (Y/N)?"
	if key.get.upper == "N" then exit
	run
end function

// Show the treasure found; add it to our list and score
getTreasure = function(p, found)
	td.setCell p.col, p.row, found
	treasureSnd.play
	img = td.tileSet.getImage(32*(found-kCellTreasure+2), 0, 32, 32)
	gfx.drawImage img, treasureListX + 20, treasureListY
	points = 100 + ceil(1E6/(10+time))
	gfx.print points, treasureListX+60, treasureListY+6, gold, "small"
	globals.treasureListY = treasureListY - 40
	globals.score = score + points
	drawTimeAndScore
	wait 0.5
	globals.treasuresLeft = treasuresLeft - 1
	if not treasuresLeft then gameWon
end function

// Reveal the given grid position. If it's a bomb,
// game over! Otherwise show how many neighboring cells
// contain bombs. If that is 0, reveal all neighbors.
reveal = function(p)
	if td.cell(p.col, p.row) < kCellGrass then return
	found = hidden[p.col][p.row]
	// If we found a bomb, then it's game-over
	if found == kCellBomb then
		doBoom p
		return
	end if
	// If we found treasure, reveal it
	if found >= kCellTreasure and found < kCellTreasure+6 then
		getTreasure p, found
		return
	end if
	// Otherwise, count bombs and show the number
	bombCount = 0
	for n in p.neighbors
		if hidden[n.col][n.row] == kCellBomb then
			bombCount = bombCount + 1
		end if
	end for
	td.setCell p.col, p.row, bombCount
	// ...and if the bomb count was 0, then reveal neighbors too
	if bombCount == 0 then
		for n in p.neighbors; reveal n; end for
	end if
end function

// Setup and main loop
buryStuff
while true
	drawTimeAndScore
	if mouse.button(0) then handleClick(0)
	if mouse.button(1) then handleClick(1)
	yield
end while
