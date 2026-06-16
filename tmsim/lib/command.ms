// command.ms - tdos command class

Command = {}

Command.init = function(name, description, funcName)
    cmd = new Command
    cmd.name = name
    cmd.description = description
    cmd.funcName = @funcName
end function

Command.run = function
    self.funcName
end function

