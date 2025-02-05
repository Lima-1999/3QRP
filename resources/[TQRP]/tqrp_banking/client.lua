ESX = nil

local inMenu = false
local atATM = false

local bankLocations = {
    {i = 108, c = 77, x = 241.727, y = 220.706, z = 106.286, s = 0.8, n = "Pacific Bank"}, -- blip id, blip color, x, y, z, scale, name/label
	{i = 108, c = 0, x = 150.266, y = -1040.203, z = 29.374, s = 0.7, n = "Bank"},
	{i = 108, c = 0, x = -1212.980, y = -330.841, z = 37.787, s = 0.7, n = "Bank"},
	{i = 108, c = 0, x = -2962.582, y = 482.627, z = 15.703, s = 0.7, n = "Bank"},
	{i = 108, c = 0, x = -112.202, y = 6469.295, z = 31.626, s = 0.7, n = "Bank"},
	{i = 108, c = 0, x = 314.187, y = -278.621, z = 54.170, s = 0.7, n = "Bank"},
	{i = 108, c = 0, x = -351.534, y = -49.529, z = 49.042, s = 0.7, n = "Bank"},
	{i = 108, c = 0, x = 1175.0643310547, y = 2706.6435546875, z = 38.094036102295, s = 0.7, n = "Bank"}
}

local ATMs = {-870868698, -1126237515, -1364697528, 506770882} -- ATM Object Models

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(2000)
	end
	Citizen.Wait(2000)
end)

Citizen.CreateThread(function()
    while true do
        Wait(7)
        if playerNearBank() then
            if not inMenu then
                DisplayHelpText("Pressiona ~INPUT_PICKUP~ para abrir o banco")
                if IsControlJustPressed(0, 38) then
                    openPlayersBank('bank')
                end
            end

            if IsControlJustPressed(0, 322) then
                inMenu = false
                SetNuiFocus(false, false)
                SendNUIMessage({type = 'close'})
            end
        else
            Citizen.Wait(1500)
        end
    end
end)

RegisterCommand('atm', function(source, args) -- Command to access ATM when players are near instead of spam notifications when near an ATM
    if playerNearATM() then
        openPlayersBank('atm')
    else
        exports['mythic_notify']:SendAlert('error', 'Não estás perto de nenhum ATM')
    end
end)

function openPlayersBank(type)
    local dict = 'anim@amb@prop_human_atm@interior@male@enter'
    local anim = 'enter'
    local ped = GetPlayerPed(-1)
    local time = 2500

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    Citizen.Wait(time)
    ClearPedTasks(ped)

    if type == 'bank' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openBank'})
        TriggerServerEvent('orp:bank:balance')
        atATM = false
    elseif type == 'atm' then
        inMenu = true
        SetNuiFocus(true, true)
        SendNUIMessage({type = 'openAtm'})
        TriggerServerEvent('orp:bank:balance')
        atATM = true
    end
end

function playerNearATM() -- Check if a player is near ATM when they use command /atm
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)

    for i = 1, #ATMs do
        local atm = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, ATMs[i], false, false, false)
        local atmPos = GetEntityCoords(atm)
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, atmPos.x, atmPos.y, atmPos.z, true)

        if dist < 1.5 then
            return true
        end
    end
end

function playerNearBank() -- Checks if a player is near a bank
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for _, search in pairs(bankLocations) do
        local dist = GetDistanceBetweenCoords(search.x, search.y, search.z, pos.x, pos.y, pos.z, true)

        if dist <= 1.0 then
            return true
        end
    end
end

local blipsLoaded = false

Citizen.CreateThread(function() -- Add bank blips
   -- while true do
     --   Citizen.Wait(2000)
      --  if not blipsLoaded then
            for k, v in ipairs(bankLocations) do
                local blip = AddBlipForCoord(v.x, v.y, v.z)
		        SetBlipSprite(blip, v.i)
		        SetBlipScale(blip, v.s)
		        SetBlipAsShortRange(blip, true)
			    SetBlipColour(blip, v.c)
		        BeginTextCommandSetBlipName("STRING")
		        AddTextComponentString(tostring(v.n))
		        EndTextCommandSetBlipName(blip) 
            end
         --   blipsLoaded = true
     --   end
  --  end
end)

RegisterNetEvent('orp:bank:info')
AddEventHandler('orp:bank:info', function(balance)
    local id = PlayerId()
    local playerName = GetPlayerName(id)

    SendNUIMessage({
		type = "updateBalance",
		balance = balance,
		player = playerName
		})
end)

RegisterNUICallback('deposit', function(data)
    if not atATM then
        TriggerServerEvent('orp:bank:deposit', tonumber(data.amount))
        TriggerServerEvent('orp:bank:balance')
    end
end)

RegisterNUICallback('withdrawl', function(data)
    TriggerServerEvent('orp:bank:withdraw', tonumber(data.amountw))
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNUICallback('balance', function()
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNetEvent('orp:balance:back')
AddEventHandler('orp:balance:back', function(balance)
    SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

function closePlayersBank()
    local dict = 'anim@amb@prop_human_atm@interior@male@exit'
    local anim = 'exit'
    local ped = GetPlayerPed(-1)
    local time = 1800

    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(7)
    end

    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
    TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
    Citizen.Wait(time)
    ClearPedTasks(ped)
    inMenu = false
end

function closeInvest()
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
    inMenu = false
end

RegisterNUICallback('transfer', function(data)
    TriggerServerEvent('orp:bank:transfer', data.to, data.amountt)
    TriggerServerEvent('orp:bank:balance')
end)

RegisterNetEvent('orp:bank:notify')
AddEventHandler('orp:bank:notify', function(type, message)
    exports['mythic_notify']:SendAlert(type, message)
end)

AddEventHandler('onResourceStop', function(resource)
    inMenu = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeAll'})
end)


RegisterNUICallback('NUIFocusOff', function()
    closePlayersBank()
end)

RegisterNUICallback('openInvest', function()
    closeInvest()
    TriggerEvent('invest:open')
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
