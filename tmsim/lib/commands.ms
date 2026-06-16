// commands.ms - tdos command list

import "command"      // tdos command class
import "cmdData"      // tdos command functions and data

Commands = {}

Commands.init = function
    cmd = new Commands
    cmd.list = {}
    for c in cmdData.list.indexes
        cmd.add(c, cmdData.list[c].description, cmdData.list[c].funcName)
    end for
    if debug then print("loaded " + len(cmd.list) + " commands")
end function

Commands.add = function(name, description, funcName)
    c = new command.Command
    self.list[name] = c.init(name, description, funcName)
end function

Commands.get = function(name)
    return self.list[name]
end function

Commands.run = function(name)
    self.list[name].run
end function
