// Yearly income calculator

amountPerHour = val(input("Hourly rate? "))
hoursPerWeek = val(input("Hours per week? "))
weeksPerYear = 50   // assume 2 weeks vacation
amountPerYear = amountPerHour * hoursPerWeek * weeksPerYear
print "That's " + amountPerYear + " per year,"
print "or about " + round(amountPerYear / 12) + " per month!"