// time.ms - time and date class

import "datetime"

Time = {
		"year": 1985,
		"month": 10,
		"day": 26,
		"hour": 12,
		"minute": 30,
}

Time.test = function
		if debug then print("Time.test")
		datetime.test
end function

Time.date = function
		return self.month + "/" + self.day + "/" + self.year
end function

Time.time = function
		return self.hour + ":" + self.minute
end function