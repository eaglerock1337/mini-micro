// time.ms - time and date class

import "datetime"

Time = {
		"year": 1985,
		"month": 10,
		"day": 26,
		"hour": 12,
		"minute": 00,
}

Time.test = function
		if debug then print("Time.test")
end function

Time.date = function
		return (" " + self.month)[-2:] + "/" +
		    (" " + self.day)[-2:] + "/" +
				("   " + self.year)[-4:]
end function

Time.time = function
		return (" " + self.hour)[-2:] + ":" + ("0" + self.minute)[-2:]
end function