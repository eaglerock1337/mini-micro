// view.ms - time machine simulator view class

View = {}

View.init = function(name, textMap, actionMap)
    v = new View
    v.name = name
    v.textMap = textMap
    v.actionMap = actionMap
    v.active = false
    return v
end function

View.run = function
    if debug then print "View.run"
    self.active = true
    self.validate

    while self.active
        print(self.textMap[header])
        print(self.textMap[text])
        for action in self.actionMap
            print(action.key & ": " & action.description)
        end for
        choice = input(self.textMap[prompt])
        print("You chose: " & choice)
        self.active = false
    end while
end function

View.validate = function
    if debug then print("View.validate")
    if not self.textMap.hasIndex(header) then
        print("View.validate: text not found for header: " & header)
        exit
    end if
    if not self.textMap.hasIndex(text) then
        print("View.validate: text not found for text: " & text)
        exit
    end if
    if not self.textMap.hasIndex(prompt) then
        print("View.validate: text not found for prompt: " & prompt)
        exit
    end if
end function