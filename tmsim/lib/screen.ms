// screen.ms - game display layer singleton

// reset displays

reset = function
    clear
    if debug then
        display(3).color = gruvbox.bg
    else
        display(3).mode displayMode.off
    end if
end function

// displays

consoleBody = function; return display(0); end function
consoleData = function; return display(1); end function
consoleBorder = function; return display(2); end function
debugText = function; return display(3); end function
sprite = function; return display(4); end function
gfx = function; return display(5); end function
tile = function; return display(6); end function
bg = function; return display(7); end function


// display switching routines

useMainDisplay = function
    display(0).mode = displayMode.off
    display(1).mode = displayMode.off
    display(2).mode = displayMode.off
    display(4).mode = displayMode.sprite
    display(5).mode = displayMode.pixel
    display(6).mode = displayMode.off
end function

useConsole = function
    display(0).mode = displayMode.text
    display(1).mode = displayMode.text
    display(2).mode = displayMode.text
    display(4).mode = displayMode.off
    display(5).mode = displayMode.off
    display(6).mode = displayMode.off
end function

useGui = function
    display(0).mode = displayMode.off
    display(1).mode = displayMode.off
    display(2).mode = displayMode.off
    display(4).mode = displayMode.sprite
    display(5).mode = displayMode.pixel
    display(6).mode = displayMode.tile
end function

// entrypoint at load time

if debug then print("screen loaded")
reset
useMainDisplay