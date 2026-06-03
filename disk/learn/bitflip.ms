// Bit-flip game
b0A = 0
b0B = 0
b0C = 0
b1A = 0
b1B = 0
b1C = 0
b2A = 0
b2B = 0
b2C = 0
print "Can you flip all the bits to 1?"
print
while true
    print "Bit: "
    print "  A: " + b0A + " " + b1A + " " + b2A
    print "  B: " + b0B + " " + b1B + " " + b2B
    print "  C: " + b0C + " " + b1C + " " + b2C
    print "     - - -"
    print "     0 1 2"
    print
    if b0A + b0B + b0C + b1A + b1B + b1C + b2A + b2B + b2C == 9 then
        print "You win!"
        break
    end if
    cmd = input("Which row and column to flip (e.g. A0)? ").upper
    if cmd.len != 2 then continue
    row = cmd[0]
    col = val(cmd[1])
    if row == "A" or col == 0 then b0A = 1 - b0A
    if row == "A" or col == 1 then b1A = 1 - b1A
    if row == "A" or col == 2 then b2A = 1 - b2A
    if row == "B" or col == 0 then b0B = 1 - b0B
    if row == "B" or col == 1 then b1B = 1 - b1B
    if row == "B" or col == 2 then b2B = 1 - b2B
    if row == "C" or col == 0 then b0C = 1 - b0C
    if row == "C" or col == 1 then b1C = 1 - b1C
    if row == "C" or col == 2 then b2C = 1 - b2C
end while