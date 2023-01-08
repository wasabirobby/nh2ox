-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

local menuLabel = 'Menu' -- Edit with your language or whatever really

local function removeTags(str)
    local string = str
    local trimmedString = string:gsub("/.*>", "")
    trimmedString = trimmedString:gsub(".*>", "")
    trimmedString = trimmedString:gsub("<", "")
    return trimmedString
end


AddEventHandler('wasabi_nh2ox:trigger', function(data)
    TriggerEvent(data.event, data.arg1, data.arg2, data.arg3)
end)

RegisterNetEvent('nh-context:sendMenu', function(data)
    if not data then return end
    local Options = {}
    for i=1, #data do
        if data[i].params.args then
            Options[#Options + 1] = {
                title = removeTags(data[i].header),
                description = removeTags(data[i].txt),
                event = data[i].params.event,
                args = data[i].params.args
            }
        elseif data[i].params.arg1 then
            Options[#Options + 1] = {
                title = removeTags(data[i].header),
                description = removeTags(data[i].txt),
                event = 'wasabi_nh2ox:trigger',
                args = {
                    event = data[i].params.event,
                    args1 = data[i].params.args1,
                    args2 = data[i].params.args2 or nil,
                    args3 = data[i].params.args3 or nil
                }
            }
        end
    end
    lib.registerContext({
        id = 'nh2ox_'..removeTags(data[1].header),
        title = menuLabel,
        options = Options
    })
    lib.showContext('nh2ox_'..removeTags(data[1].header))
end)



RegisterNetEvent("nh-context:cancelMenu", function()
    lib.hideContext(false)
end)