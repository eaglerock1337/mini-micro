// console.ms - time machine console & tui

import "commands"

Console = {}
Console.width = 68
Console.height = 26
Console.side = 17
Console.body = 48

Console.commands = commands.commandList

Console.reset = function
	if debug then print("Console.reset")
	
	screen.consoleBody.clear
	screen.consoleBody.color = gruvbox.aqua
	screen.consoleData.clear
	screen.consoleData.color = gruvbox.gray
	screen.consoleBorder.clear
	screen.consoleBorder.color = gruvbox.blue
	if not debug then screen.consoleBorder.backColor = gruvbox.dark
	
	self.drawBorder
end function

Console.goToXY = function(row)
	screen.consoleBorder.column = 0
	screen.consoleBorder.row = row
end function

Console.drawBorderLine = function(row)
	self.goToXY(row)
	screen.consoleBorder.print "+" + "-" * (self.width-2), ""
	screen.consoleBorder.setCell self.width-1, row, "+"
	screen.consoleBorder.setCellColor self.width-1, row, gruvbox.blue
end function

Console.drawHeaderLine = function(row)
	self.goToXY(row)
	screen.consoleBorder.print "|" + " " * (self.width-2) + "|", ""
end function

Console.drawSideLine = function(row, char = "-")
	self.goToXY(row)
	screen.consoleBorder.print "|" + char * self.side + "|" + " " * self.body + "|", ""
end function

Console.drawBodyLines = function(row, count = 1)
	for i in range(row, row - count + 1)
		self.drawSideLine(i, " ")
	end for
end function

Console.drawBorder = function
	self.drawBorderLine(25)
	self.drawHeaderLine(24)
	self.drawBorderLine(23)
	self.drawBodyLines(22, 4)
	self.drawSideLine(18)
	self.drawBodyLines(17, 8)
	self.drawSideLine(9)
	self.drawBodyLines(8, 8)
	self.drawBorderLine(0)
end function
