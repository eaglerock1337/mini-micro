nums = range(2, 12)
rolls = 1000
result = [0, 0]

for num in nums
    result.push(0)
end for

roll = function
  return ceil(rnd * 6) + ceil(rnd * 6)
end function

for i in range(rolls)
    response = roll()
    result[response] = result[response] + 1
end for

print "Results from " + rolls + " dice rolls:"
for num in nums
    print num + ": " + result[num]
end for