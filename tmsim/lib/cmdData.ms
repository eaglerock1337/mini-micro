// cmdData.ms - tdos function list and metadata

lookaway = function
    print("lookaway placeholder")
end function

reboot = function
    print("reboot placeholder")
end function

list = {}
list["lookaway"] = {
    "description": "look away from the screen",
    "funcName": @lookaway,
}
list["reboot"] = {
    "description": "reboot the computer",
    "funcName": @reboot,
}