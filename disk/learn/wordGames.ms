import "mapUtil"
import "listUtil"
import "mathUtil"
import "sounds"

clear
text.color = color.silver

display(2).mode = displayMode.pixel
overlay = display(2)
overlay.clear

kRows = 5
kCols = 5

words = file.readLines("/sys/data/englishWords.txt")
for i in range(0, words.len-1)
	words[i] = words[i].upper
end for

freq = {"A": 40116, "H": 12329, "R": 38506, "D": 21338,
    "V": 5427, "K": 5275, "S": 49035, "B": 10303, "C": 21554,
    "I": 47049, "U": 17694, "E": 62157, "L": 27956, "O": 33150,
    "N": 37001, "G": 16930, "M": 14495, "T": 36984, "Y": 8191,
    "J": 941, "Z": 2090, "P": 15815, "F": 7635, "W": 5081,
    "Qu": 990, "X": 1487 }

totalFreq = freq.values.sum

randomLetter = function
	i = floor(rnd * totalFreq)
	for kv in freq
		if i < kv.value then return kv.key
		i = i - kv.value
	end for
end function

blockPic = file.loadImage("/sys/pics/Block.png")
drawBlock = function(letter, x=100, y=100)
	gfx.drawImage blockPic, x, y, 40, 40
	if letter.len < 2 then
		gfx.print letter, x+8, y+4, color.black, "large"
	else
		gfx.print letter, x+6, y+8, color.black
	end if
end function

Tile = new Sprite
Tile.letter = ""
Tile.scale = 2
Tile.tint = color.yellow
Tile.target = {"x": 0, "y": 0}
Tile.speed = 100
Tile.localBounds = new Bounds
Tile.localBounds.width = 36
Tile.localBounds.height = 36

Tile.goTo = function(x, y, speed)
	self.target.x = x
	self.target.y = y
	if speed != null then self.speed = speed
end function

Tile.goToGridPos = function(col, row)
	self.goTo 300 + col * 90, 135 + row * 90
end function

Tile.update = function(dt = 0.1)
	mathUtil.moveTowardsXY(self, self.target, self.speed * dt)
end function

Tile.updateAll = function(dt = 0.1)
	updatedAny = false
	for s in spriteDisp.sprites
		if not s isa Tile then continue
		if s.x == s.target.x and s.y == s.target.y then continue
		s.update
		updatedAny = true
	end for
	return updatedAny
end function

Tile.selected = function
	return self.tint != Tile.tint
end function
// 2D array to keep track of the tiles that belong in each
// row and column of the grid. Indexed by first column,
// and within a column indexed bottom-up, so within a column
// we can easily move soemthing and the rest shift down.
grid = list.init2d(kCols, kRows)

makeSprite = function(letter)
	gfx.fillRect 0, 0, 40, 40, color.clear
	drawBlock letter, 0, 0
	spr = new Tile
	spr.image = gfx.getImage(0, 0, 40, 40)
	spr.letter = letter
	return spr
end function

letterSprites = {}  // key: letter; value: Tile
for code in range("A".code, "Z".code)
	gfx.clear
	c = char(code)
	if c == "Q" then c = "Qu"
	letterSprites[c] = makeSprite(c)
end for
gfx.clear

display(4).mode = displayMode.sprite
spriteDisp = display(4)
spriteDisp.clear

newTile = function(col, row)
	tile = new letterSprites[randomLetter]
	tile.target = {"x": 0, "y": 0}  // make sure tile has its own target map
	spriteDisp.sprites.push tile
	tile.goToGridPos col, row
	tile.x = tile.target.x
	tile.y = tile.target.y + 500 + 50 * rnd + 100 * row
	grid[col][row] = tile
	return tile
end function

for col in range(0, kCols-1)
	for row in range(0, kRows-1)
		newTile col, row
	end for
end for

tileUnderMouse = function
	for s in spriteDisp.sprites
		if not s isa Tile then continue
		if s.contains(mouse) then return s
	end for
end function

wordInProgress = ""
addToWord = function(tile)
	globals.wordInProgress = wordInProgress + tile.letter
	if lastTile != null then
		overlay.line lastTile.x, lastTile.y, tile.x, tile.y, "#88FF8888", 5
	end if
	globals.lastTile = tile
	tile.tint = color.aqua
	tile.selected = true
end function

trackMouseOnTiles = function
	while mouse.button
		updateTime
		yield
		tile = tileUnderMouse
		if tile == null or tile.selected then continue
		if mathUtil.distance(tile, lastTile) > 150 then continue
		addToWord tile
	end while
end function

clearUsedTiles = function
	for col in range(0, kCols-1)
		// first iterate top-down, deleting any selected tiles
		for row in range(kRows-1, 0)
			tile = grid[col][row]
			if tile == null or not tile.selected then continue
			spriteDisp.sprites.removeVal tile  // remove sprite
			grid[col].remove row  // remove used tile
			grid[col].push null  // add empty spot to column
		end for
		// then iterate again bottom-up, adding new tiles
		for row in range(0, kRows-1)
			if grid[col][row] == null then
				newTile col, row
			else
				grid[col][row].goToGridPos col, row
			end if
		end for
	end for
	overlay.clear
	globals.lastTile = null
end function

deselectTiles = function
	for col in range(0, kCols-1)
		for row in range(0, kRows-1)
			tile = grid[col][row]
			tile.selected = false
			tile.tint = Tile.tint
		end for
	end for
	overlay.clear
	globals.lastTile = null
end function

drawWord = function(word, valid)
	if valid then c = color.aqua else c = color.teal
	gfx.clear
	gfx.print word, 480 - word.len / 2 * 20.5, 550, c, "large"
end function

score = 0
wordsFound = []  // each element will be [word, points]
scoreWord = function(word)
	valid = words.contains(word)
	drawWord word, valid
	if not valid then return false
	points = 2 ^ word.len
	wordsFound.insert 0, [word, points]
	text.row = 21
	for w in wordsFound
		print(w[0] + " " * 11)[:11] + (" " * 5 + w[1])[-5:]
		if text.row < 2 then break
	end for
	globals.score = score + points
	text.row = 25
	print "SCORE: " + score
	return true
end function

endTime = time + 120
updateTime = function
	timeLeft = ceil(endTime - time)
	text.row = 25
	text.column = 58
	if timeLeft <= 0 then
		print "TIME'S UP!"
	else
		mins = floor(timeLeft / 60)
		secs = ("00" + (timeLeft % 60))[-2:]
		print "TIME: " + mins + ":" + secs
	end if
end function

lastTile = null
while true
	while Tile.updateAll; updateTime; yield; end while
	if time > endTime then break
	while not mouse.button; updateTime; yield; end while
	tileHit = tileUnderMouse
	if tileHit == null or tileHit.selected then continue
	addToWord tileHit
	trackMouseOnTiles
	
	if scoreWord(wordInProgress) then
		sounds.daDing.play
		clearUsedTiles
	else
		sounds.land.play
		deselectTiles
	end if
	wordInProgress = ""
end while

s = "Final Score: " + score
text.row = 2
text.column = 34 - s.len / 2
print s
sounds.wow.play
