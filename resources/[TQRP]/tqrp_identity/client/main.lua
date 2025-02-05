local guiEnabled = false
local myIdentity = {}
local myIdentifiers = {}
local hasIdentity = false
local isDead = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

function EnableGui(state)
	SetNuiFocus(state, state)
	guiEnabled = state
	if guiEnabled then
		disable()
	end
	TransitionToBlurred(500)
	SendNUIMessage({
		type = "enableui",
		enable = state
	})
end

RegisterNetEvent('tqrp_identity:showRegisterIdentity')
AddEventHandler('tqrp_identity:showRegisterIdentity', function()
	if not isDead then
		EnableGui(true)
	end
end)

RegisterNetEvent('tqrp_identity:identityCheck')
AddEventHandler('tqrp_identity:identityCheck', function(identityCheck)
	hasIdentity = identityCheck
end)

RegisterNetEvent('tqrp_identity:saveID')
AddEventHandler('tqrp_identity:saveID', function(data)
	myIdentifiers = data
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
		TransitionFromBlurred(500)
	else
		exports['mythic_notify']:SendAlert('error', "Tens de criar uma personagem para poderes jogar.")
	end
end)

RegisterNUICallback('register', function(data, cb)
	local reason = ""
	myIdentity = data
	for theData, value in pairs(myIdentity) do
		if theData == "firstname" or theData == "lastname" then
			reason = verifyName(value)
			if reason ~= "" then
				break
			end
		elseif theData == "dateofbirth" then
			if value == "invalid" then
				reason = "Idade Inválida!"
				break
			end
		elseif theData == "height" then
			local height = tonumber(value)
			if height then
				if height > 200 or height < 140 then
					reason = "Tamanho Errado!"
					break
				end
			else
				reason = "Tamanho Errado!"
				break
			end
		end
	end
	
	if reason == "" then
		TriggerServerEvent('tqrp_identity:setIdentity', data, myIdentifiers)
		EnableGui(false)
		TransitionFromBlurred(500)
		Citizen.Wait(1500)
		TriggerEvent('tqrp_skin:openSaveableMenu', myIdentifiers.id)
	else
		exports['mythic_notify']:SendAlert('error', reason)
	end
end)

function disable()
	Citizen.CreateThread(function()
		while guiEnabled do
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
			Citizen.Wait(10)
		end
	end)
end

function verifyName(name)
	-- Don't allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return 'O teu nome é muito longo ou muito comprido'
	end
	
	--[[ Don't allow special characters (doesn't always work)
	local count = 0
	for i in name:gmatch('[abcććšđžČĆĐŽdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Your player name contains special characters that are not allowed on this server.'
	end]]
	
	-- Does the player carry a first and last name?
	-- 
	-- Example:
	-- Allowed:     'Bob Joe'
	-- Not allowed: 'Bob'
	-- Not allowed: 'Bob joe'
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	--[[if spacesInName > 3 then
		return 'Your name contains more than two spaces'
	end]]
	
	if spacesWithUpper ~= spacesInName then
		return 'O teu nome tem de começar por letra Maiúscula.'
	end

	return ''
end
