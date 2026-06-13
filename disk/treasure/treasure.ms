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
GridPos = {"col":0, "row":0}

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
	inCell = null
	while mouse.button(btn)
		inCell = (GridPos.atXY(mouse) == hitPos)
		if inCell then
			td.setCellTint hitPos.col, hitPos.row, "DDDDDD"
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
			td.setCell hitPos.col, hitPos,row, kCellFlag
		end if
	end if
end function

reveal = function(val)
	print(val)
end function
