// console.ms - time machine console & tui

import "gruvbox"
import "screen"
import "tm"

Console = {}
Console.width = 68
Console.height = 26
Console.side = 17
Console.body = 48

Console.reset = function
	if debug then print "Console.reset"
	
	screen.consoleBody.clear
	screen.consoleBody.color = gruvbox.aqua
	screen.consoleData.clear
	screen.consoleData.color = gruvbox.gray
	screen.consoleBorder.clear
	screen.consoleBorder.color = gruvbox.blue
	if not debug then screen.consoleBorder.backColor = gruvbox.dark
	
	self.drawBorder
end function

Console.goToXY = function(display, row, column=0)
	display.column = column
	display.row = row
end function

Console.drawBorderLine = function(row)
	self.goToXY(@screen.consoleBorder, row)
	screen.consoleBorder.print "+" + "-" * (self.width-2), ""
	screen.consoleBorder.setCell self.width-1, row, "+"
	screen.consoleBorder.setCellColor self.width-1, row, gruvbox.blue
end function

Console.drawHeaderLine = function(row)
	self.goToXY(@screen.consoleBorder, row)
	screen.consoleBorder.print "|" + " " * (self.width-2) + "|", ""
end function

Console.drawLine = function(row, sideChar = " ", bodyChar = " ")
	self.goToXY(@screen.consoleBorder, row)
	screen.consoleBorder.print "|" + sideChar * self.side + "|" + bodyChar * self.body + "|", ""
end function

Console.drawSideHeader = function(row)
	self.drawLine(row, "-", " ")
end function

Console.drawBodyHeader = function(row)
    self.drawLine(row, " ", "-")
end function

Console.drawDoubleHeader = function(row)
    self.drawLine(row, "-", "-")
end function

Console.drawBodyLines = function(row, count = 1)
	for i in range(row, row - count + 1)
		self.drawLine(i, " ", " ")
	end for
end function

Console.drawBorder = function
	self.drawBorderLine(25)
	self.drawHeaderLine(24)
	self.drawBorderLine(23)
	self.drawBodyLines(22, 4)
	self.drawSideHeader(18)
	self.drawBodyLines(17, 8)
	self.drawSideHeader(9)
	self.drawBodyLines(8, 6)
    self.drawBodyHeader(2)
    self.drawLine(1)
	self.drawBorderLine(0)
end function

Console.drawTitle = function
    self.goToXY @screen.consoleData, 24, 2
    screen.consoleData.print "TDOS v" + version
    self.goToXY @screen.consoleData, 24, self.width - self.body
    screen.consoleData.print sim.currentTime.fullDate
    self.goToXY @screen.consoleData, 24, self.width - 13
    screen.consoleData.print ("     " + sim.currentTime.time)[-11:]
end function

Console.prompt = function
    if debug then print "Console.prompt"
    yield  // allow refresh before input
    
    // use screen.debugText layer to get input to work correctly
    self.drawTitle
    curRow = screen.debugText.row
    curCol = screen.debugText.column
    curColor = screen.debugText.color
	self.goToXY(@screen.debugText, 1, self.width - self.body)
    screen.debugText.print " " * self.body    
	self.goToXY(@screen.debugText, 1, self.width - self.body)
    screen.debugText.color = gruvbox.aqua
	command = input("> ")
    text = screen.debugText

    // put debugText layer back how it was
    screen.debugText.row = curRow
    screen.debugText.column = curCol
    screen.debugText.color = curColor
    if debug then print "prompt: '" + command + "'"
    return command
end function