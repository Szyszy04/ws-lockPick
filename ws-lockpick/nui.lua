local display = false
local result = nil

RegisterCommand("lockpick", function(source, args)
    SetDisplay(not display)
end)

RegisterNUICallback("nuiResponse", function(data, cb)
    result = data.success
    SetDisplay(false)
    cb("ok")
end)

function startWsLockpick()
	result = nil
    SetDisplay(not display)
    
    while result == nil do 
        Wait(100)
    end
    return result
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display) 
        DisableControlAction(0, 2, display) 
        DisableControlAction(0, 142, display) 
        DisableControlAction(0, 18, display)
        DisableControlAction(0, 322, display)
        DisableControlAction(0, 106, display) 
    end
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end