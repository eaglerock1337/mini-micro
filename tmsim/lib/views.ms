// views.ms - time machine simulator main view class

import "view"

Views = {}

Views.init = function
    self.viewList = {}
    viewList.append(View.init("inside",
        {
            header: "Inside the Time Machine",
            text: "You are sitting inside the time machine. The controls are in front of you.",
            prompt: "What do you want to do?"
        },
        {
            "Look at the monitor": @actions.lookAtMonitor,
            "Look at the dashboard": @actions.lookAtDashboard,
            "Look at the control panel": @actions.lookAtControlPanel,
            "Look at the supplies": @actions.lookAtSupplies,
            "Exit the time machine": @actions.exitTimeMachine,
            "Wait inside the time machine": @actions.waitInside,
            "Pause the simulation": @actions.pause
        }
    ))
    viewList.append(View.init("outside",
        {
            header: "Outside the Time Machine",
            text: "You are standing outside the time machine.",
            prompt: "What do you want to do?"
        },
        {
            "Enter the time machine": @actions.enterTimeMachine,
            "Wait outside the time machine": @actions.waitOutside,
            "Pause the simulation": @actions.pause
        }
    ))
    return viewList
end function

Views.run = function(view)
    if debug then print("Views.run: " & view.name)
    self.viewList[view].run
end function