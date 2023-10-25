local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    QBCore.Functions.CreateUseableItem("speed_pill", function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetItemByName("speed_pill") then
            TriggerClientEvent("PlayerMaxSpeed", src)
            Player.Functions.RemoveItem("speed_pill", 1)
        end
    end)
end)