--[[RegisterServerEvent('tqrp_phone:server:CharacterSpawned')
AddEventHandler('tqrp_phone:server:CharacterSpawned', function()
    local src = source
    local char = exports['tqrp_phone']:FetchComponent('Fetch'):Source(src):GetData('character')
    local cData = char:GetData()

    Citizen.CreateThread(function()
        exports['ghmattimysql']:execute('SELECT * FROM phone_tuner WHERE charid = @charid', { ['charid'] = cData.id }, function(dbTunes)
            local tunes = {}
            if dbTunes[1] ~= nil then
                for k, v in pairs(dbTunes) do
                    table.insert(tunes, {
                        json.decode(v.data)
                    })
                end
            end

            TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'factory-tunes', data = Config.FactoryTunes } })
            TriggerClientEvent('tqrp_phone:client:SetupData', src, { { name = 'custom-tunes', data = tunes } })
        end)
    end)
end)
]]
AddEventHandler('tqrp_phone:shared:ComponentsReady', function()
    Callbacks = Callbacks or exports['tqrp_phone']:FetchComponent('Callbacks')

    Callbacks:RegisterServerCallback('tqrp_phone:server:SaveTune', function(source, data, cb)
        local char = exports['tqrp_phone']:FetchComponent('Fetch'):Source(source):GetData('character')
        exports['ghmattimysql']:execute('INSERT INTO phone_tuner (`charid`, `data`) VALUES(@charid, @data)', { ['charid'] = char:GetData('id'), ['data'] = json.encode(data.tune) }, function(response)
            data.tune.id = response.insertId
            cb(data.tune)
        end)
    end)

    Callbacks:RegisterServerCallback('tqrp_phone:server:DeleteTune', function(source, data, cb)
        local char = exports['tqrp_phone']:FetchComponent('Fetch'):Source(source):GetData('character')
        exports['ghmattimysql']:execute('DELETE FROM phone_tuner WHERE id = @id AND charid = @charid', { ['id'] = data.id, ['charid'] = char:GetData('id') }, function(response)
            cb(response.affectedRows > 0)
        end)
    end)
end)