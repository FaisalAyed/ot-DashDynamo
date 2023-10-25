local QBCore = exports['qb-core']:GetCoreObject()


--functions
function DrawText2D(x, y, text)
    SetTextFont(1)
    SetTextProportional(1)
    SetTextScale(5.0, 5.0)
    SetTextColour(80, 0, 150, 255)
    SetTextDropshadow(150, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 150)
    SetTextDropshadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end
local TextCounter = function(i)
    Citizen.CreateThread(function()
        local n = i * 100
        while n > 0 do
            Wait(0)
            DrawText2D(0.85, 0.7, math.floor(n/100))
            n = n - 1
        end
    end)
end
local counter = function(n)
    while n > 0 do
        n = n - 1
        Wait(1000)
    end
end


--Events
RegisterNetEvent("PlayerMaxSpeed")
AddEventHandler("PlayerMaxSpeed" ,function()
    local animDict = "mini@triathlon"
    local player = PlayerId()
    local playerPed = GetPlayerPed(-1)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(0)
    end
    QBCore.Functions.Notify("ًWorm Up ", "primary", 5500)
    TaskPlayAnim(playerPed, animDict, "ig_2_gen_warmup_01", 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(7000)
    QBCore.Functions.Notify("You now have super speed!", "success", 2000)
    SetPedMoveRateOverride(player,10.0)
    SetRunSprintMultiplierForPlayer(player, 1.49)
    TextCounter(10)
    counter(10)
    SetRunSprintMultiplierForPlayer(player, 1.0)
    QBCore.Functions.Notify("Super speed wore off.", "success", 3000)
end)
RegisterNetEvent("MedicineShop")
AddEventHandler("MedicineShop", function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "pharmcy", Config.Items)
    PlayPedAmbientSpeechNative(Doctor, "GENERIC_THANKS", "SPEECH_PARAMS_STANDARD")
end)



--Threads

CreateThread(function()
    local hash = "s_m_m_doctor_01"
    local coord = vector4(-171.4646, 6386.9805, 31.4953, 131.0089)
    local blip = AddBlipForCoord(coord.x, coord.y, coord.z)
    SetBlipScale(blip, 0.8)
    SetBlipSprite(blip, 93)
    SetBlipColour(blip, 2)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pharmcy")
    EndTextCommandSetBlipName(blip)
    SetBlipAsShortRange(blip, true)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
    Doctor = CreatePed(2, hash, coord.x, coord.y, coord.z - 1, coord.w, true, false)
    SetEntityInvincible(Doctor, true)
    FreezeEntityPosition(Doctor, true)
    SetBlockingOfNonTemporaryEvents(Doctor, true)
    TaskStartScenarioInPlace(Doctor, "WORLD_HUMAN_BUM_STANDING", 0, 1)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("MissionRowDutyClipboard", vector3(-171.54, 6386.51, 31.5), 1.4, 2, {
        name="pharmcy",
        heading=315,
        --debugPoly=true,
        minZ=28.3,
        maxZ=32.3,
    }, {
        options = {
            {
                type = "client",
                event = "MedicineShop",
                icon = "fas fa-capsules",
                label = "Buy medicine",
            },
        },
        distance = 1.5
    })
end)


