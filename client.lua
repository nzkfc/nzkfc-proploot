local RSGCore = exports['rsg-core']:GetCoreObject()
local lootedProps = {}

CreateThread(function()
    local propModels = {}
    for _, prop in ipairs(Config.LootableProps) do
        table.insert(propModels, prop.model)
    end
    
    exports.ox_target:addModel(propModels, {
        {
            name = 'loot_prop',
            label = 'Search',
            icon = 'fa-solid fa-magnifying-glass',
            distance = 2.0,
            onSelect = function(data)
                LootProp(data.entity)
            end,
            canInteract = function(entity)
                local coords = GetEntityCoords(entity)
                local propId = string.format("%.2f_%.2f_%.2f", coords.x, coords.y, coords.z)
                return not lootedProps[propId]
            end
        }
    })
end)

function LootProp(entity)
    local coords = GetEntityCoords(entity)
    local propId = string.format("%.2f_%.2f_%.2f", coords.x, coords.y, coords.z)
    local propModel = GetEntityModel(entity)
    local category = nil
    
    for _, prop in ipairs(Config.LootableProps) do
        if prop.model == propModel then
            category = prop.category
            break
        end
    end
    
    if not category then return end
    
    lootedProps[propId] = true
    
    local playerPed = PlayerPedId()
    RequestAnimDict(Config.Animation.dict)
    while not HasAnimDictLoaded(Config.Animation.dict) do
        Wait(100)
    end
    
    TaskPlayAnim(playerPed, Config.Animation.dict, Config.Animation.anim, 8.0, -8.0, -1, Config.Animation.flag, 0, false, false, false)
    
    exports['progressbar']:Progress({
        name = "searching_prop",
        duration = Config.LootTime,
        label = "Searching...",
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }
    }, function(cancelled)
        ClearPedTasks(playerPed)
        if not cancelled then
            TriggerServerEvent('prop-loot:server:getLoot', category, propId)
        else
            lootedProps[propId] = nil
            TriggerEvent('rnotify:client:SendAlert', {
                type = 'error',
                text = 'Search cancelled',
                timeout = 3000
            })
        end
    end)
end

RegisterNetEvent('prop-loot:client:startCooldown', function(propId)
    lootedProps[propId] = true
    
    SetTimeout(Config.LootCooldown, function()
        lootedProps[propId] = nil
    end)
end)