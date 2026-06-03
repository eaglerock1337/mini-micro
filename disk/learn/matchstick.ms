// Matchstick game

qty = 15
while qty > 0
    // Human player's turn
    if qty == 1 then
        print "There is one matchstick left."
    else
        print "There are " + qty + " matchsticks."
    end if
    take = 0
    while take < 1 or take > 3 or qty - take < 0
        take = round(val(input("How many do you take? ")))
    end while
    qty = qty - take
    if qty == 0 then
        print "You took the last matchstick. I win! :)"
        break
    end if

    // Computer player's turn
    if qty == 1 then
        print "That leaves just one matchstick."
        print "I guess I have to take it. You win!"
        break
    else
        print "That leaves " + qty + " matchsticks."
    end if
    take = (qty - 1) % 4
    if take == 0 then take = ceil(rnd * 3) // random move if in a losing position
    if rnd < 0.2 then take = ceil(rnd * 3) // occasional mistake
    print "I'll take " + take + "."
    qty = qty - take
    if qty == 0 then print "Oops. You win!"
end while