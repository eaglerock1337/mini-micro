// clock.ms - time and date class

import "dateTime"

Time = {}

Time.val = "1985-10-26 13:24:00"

Time.set = function(newTime)
    self.val = newTime
end function

Time.test = function
	if debug then print "Time.test"
end function

Time.date = function
    return _dateStr(self.val, "MM/dd/yyyy")
end function

Time.time = function
    return _dateStr(self.val, "h:mm:ss tt")
end function

Time.fullDate = function
    return _dateStr(self.val, "dddd, MMMM dd, yyyy")
end function

Duration = {}

Duration.init = function(val)
    dur = new Duration
    dur.val = val
    return dur
end function
