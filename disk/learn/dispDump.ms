dispDump = function
	for layer in range(0,7)
		d = display(layer)
		print layer + ". " + displayMode.str(d.mode)
	end for
end function

dispDump