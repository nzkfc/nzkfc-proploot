local RSGCore = exports['rsg-core']:GetCoreObject()

RegisterNetEvent('prop-loot:server:getLoot', function(category, propId)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    
    if not Player then return end
    
    local lootTable = Config.LootTables[category]
    if not lootTable then return end
    
    local itemsFound = {}
    
    for _, lootItem in ipairs(lootTable) do
        local roll = math.random(1, 100)
        
        if roll <= lootItem.chance then
            local amount = math.random(lootItem.min, lootItem.max)
            Player.Functions.AddItem(lootItem.item, amount)
            TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[lootItem.item], "add", amount)
            table.insert(itemsFound, {name = lootItem.item, amount = amount})
        end
    end
    
    if #itemsFound > 0 then
        local message = "You found: "
        for i, item in ipairs(itemsFound) do
            local itemLabel = RSGCore.Shared.Items[item.name] and RSGCore.Shared.Items[item.name].label or item.name
            message = message .. item.amount .. "x " .. itemLabel
            if i < #itemsFound then
                message = message .. ", "
            end
        end
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'success',
            description = message,
            duration = 5000
        })
    else
        TriggerClientEvent('ox_lib:notify', src, {
            type = 'error',
            description = 'You found nothing...',
            duration = 3000
        })
    end
    
    TriggerClientEvent('prop-loot:client:startCooldown', src, propId)
end)