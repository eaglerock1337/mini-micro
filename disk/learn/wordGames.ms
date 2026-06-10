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
