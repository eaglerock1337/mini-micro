// commands.ms - tdos command list

import "actions"

list = []
list["lookaway"] = {
    "text": "look away from the console screen",
    "action": @actions.lookaway
}

list["reboot"] = {
    "text": "reboot the time machine computer",
    "action": @actions.reboot
}

run = function(cmd)
    if debug then print("commands.run(" + cmd + ")")
    list[cmd].run
end function
