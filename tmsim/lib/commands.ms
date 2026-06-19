// commands.ms - tdos command list

import "actions"

map = {}
map["lookaway"] = {
    "text": "look away from the console screen",
    "action": @actions.lookaway,
}

map["reboot"] = {
    "text": "reboot the time machine computer",
    "action": @actions.reboot,
}

run = function(cmd)
    map[cmd]["action"]
end function
