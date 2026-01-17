--[[
╔════════════════════════════════════════════╗
║      LiveNZ Advanced NPC Drug Selling      ║
║      Script (v1.0 - 2026)                 ║
╠════════════════════════════════════════════╣
║ Copyright (c) 2026 tzntzntntnt            ║
║ All rights reserved.                      ║
║ Usage requires permission for redistribution ║
║ and resale.                               ║
║ Support: tzntzntntnt@gmail.com            ║
╚════════════════════════════════════════════╝
--]]

local QBCore = exports['qb-core']:GetCoreObject()
local npcCooldown = {}

local function IsValidNPC(entity)
    if type(entity) == "table" and entity.entity then entity = entity.entity end
    if not entity or type(entity) ~= "number" then return false end
    if not DoesEntityExist(entity) then return false end
    if IsPedAPlayer(entity) then return false end
    if not IsPedHuman(entity) then return false end
    if IsPedInAnyVehicle(entity, false) then return false end
    if IsEntityDead(entity) then return false end
    if npcCooldown[entity] then return false end
    return true
end

local function IsBlacklistedNPC(entity)
    local model = GetEntityModel(entity)
    for _, blacklistedModel in ipairs(Config.BlacklistedNPCs) do
        if model == blacklistedModel then
            return true
        end
    end
    return false
end

local function IsPolice()
    local job = QBCore.Functions.GetPlayerData().job.name
    for _, v in pairs(Config.PoliceJobs) do if job == v then return true end end
    return false
end

local function IsInHighPayZone(coords)
    local loc = Config.HighPayZone.coords
    return #(coords - loc) <= Config.HighPayZone.radius
end

RegisterNetEvent('drugsell:client:startSell', function(data)
    if IsPolice() then
        QBCore.Functions.Notify(Config.Messages.policeBlocked, "error")
        return
    end

    QBCore.Functions.TriggerCallback('drugsell:server:canSell', function(hasEnoughPolice)
        if not hasEnoughPolice then
            QBCore.Functions.Notify(Config.Messages.noPoliceOnline, "error")
            return
        end

        local entity = data.entity or data
        if not IsValidNPC(entity) or IsBlacklistedNPC(entity) then
            QBCore.Functions.Notify(Config.Messages.notInterested[math.random(#Config.Messages.notInterested)], "error")
            return
        end

        QBCore.Functions.TriggerCallback('drugsell:server:getAvailableDrugs', function(availableDrugs)
            if #availableDrugs == 0 then
                QBCore.Functions.Notify("You have no drugs to sell.", "error")
                return
            end

            if math.random(1, 100) <= Config.NPCRefuseChance then
                QBCore.Functions.Notify(Config.Messages.notInterested[math.random(#Config.Messages.notInterested)], "error")
                npcCooldown[entity] = true
                SetTimeout(Config.Cooldown, function() npcCooldown[entity] = nil end)
                return
            end

            local drug = availableDrugs[math.random(#availableDrugs)]
            local count = math.random(Config.OfferMin, Config.OfferMax)

            local coords = GetEntityCoords(PlayerPedId())
            local highPay = IsInHighPayZone(coords)
            local base = Config.PriceRange[drug.item]
            local price = math.random(base.min, base.max) * count
            if highPay then price = price * Config.HighPayMultiplier end

            -- OX_LIB MENU REPLACEMENT
            lib.registerContext({
                id = 'drug_sell_menu',
                title = 'Street Offer',
                options = {
                    {
                        title = "Sell "..count.."x "..drug.name,
                        description = "Total: $"..price..(highPay and " (Hot Zone 💰)" or ""),
                        icon = 'hand-holding-dollar',
                        onSelect = function()
                            TriggerEvent("drugsell:client:confirmSale", { 
                                npc = entity, 
                                item = drug.item, 
                                count = count, 
                                price = price 
                            })
                        end
                    },
                    {
                        title = "Cancel",
                        description = "Walk away from the deal",
                        icon = 'xmark'
                    }
                }
            })

            lib.showContext('drug_sell_menu')
        end)
    end)
end)

RegisterNetEvent('drugsell:client:confirmSale', function(data)
    local ped = PlayerPedId()
    local npc = data.npc
    local item, count, price = data.item, data.count, data.price
    if type(npc) == "table" and npc.entity then npc = npc.entity end
    if not IsValidNPC(npc) then QBCore.Functions.Notify("This NPC lost interest.", "error") return end

    TaskTurnPedToFaceEntity(ped, npc, 800)
    TaskStandStill(npc, 4000)

    QBCore.Functions.Progressbar("selling_drugs",
        Config.Messages.selling[math.random(#Config.Messages.selling)],
        4000, false, true,
        {
            disableMovement=true,
            disableCarMovement=true,
            disableCombat=true,
        },
        {
            animDict="mp_common",
            anim="givetake1_a",
            flags=49,
        }, {}, {}, function()
            ClearPedTasksImmediately(ped)
            TriggerServerEvent("drugsell:server:sellToNPC", item, count, price, GetEntityCoords(ped))
            npcCooldown[npc] = true
            SetTimeout(Config.Cooldown, function() npcCooldown[npc] = nil end)
        end)
end)

CreateThread(function()
    exports['qb-target']:AddGlobalPed({
        options = {{
            type = 'client',
            event = 'drugsell:client:startSell',
            icon = 'fa-solid fa-hand-holding-dollar',
            label = 'Offer Drugs',
            canInteract = function(ent) return IsValidNPC(ent) and not IsBlacklistedNPC(ent) end
        }},
        distance = Config.TargetDistance
    })
end)