
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

local function isPoliceJob(job)
    for _, name in ipairs(Config.PoliceJobs) do
        if job == name then return true end
    end
    return false
end

-- Function to get cop count for both Callback and Event
local function GetCopCount()
    local cops = 0
    local players = QBCore.Functions.GetPlayers()
    for _, v in ipairs(players) do
        local Cop = QBCore.Functions.GetPlayer(v)
        if Cop and isPoliceJob(Cop.PlayerData.job.name) then
            cops = cops + 1
        end
    end
    return cops
end

QBCore.Functions.CreateCallback('drugsell:server:canSell', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player and isPoliceJob(Player.PlayerData.job.name) then
        cb(false)
        return
    end
    
    cb(GetCopCount() >= Config.MinPolice)
end)

QBCore.Functions.CreateCallback('drugsell:server:getAvailableDrugs', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then cb({}) return end
    local availableDrugs = {}
    for _, drug in pairs(Config.Drugs) do
        local item = Player.Functions.GetItemByName(drug.item)
        if item and item.amount > 0 then
            table.insert(availableDrugs, drug)
        end
    end
    cb(availableDrugs)
end)

RegisterNetEvent('drugsell:server:sellToNPC', function(item, count, price, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player or isPoliceJob(Player.PlayerData.job.name) then return end

    -- Server-side security check for police count
    if GetCopCount() < Config.MinPolice then
        TriggerClientEvent('QBCore:Notify', src, Config.Messages.noPoliceOnline, 'error')
        return
    end

    local invItem = Player.Functions.GetItemByName(item)
    if not invItem or invItem.amount < count then
        TriggerClientEvent('QBCore:Notify', src, string.format(Config.Messages.notEnoughItem or "You don't have enough %s.", item), 'error')
        return
    end

    Player.Functions.RemoveItem(item, count)
    Player.Functions.AddMoney('cash', price, 'npc-drug-sale')
    TriggerClientEvent('QBCore:Notify', src, string.format(Config.Messages.saleSuccess or "Sold %dx %s for $%d.", count, item, price), 'success')
    
    if Config.Dispatch and Config.Dispatch.enabled and math.random(1, 100) <= (Config.AlertChance or 30) then
        for _, v in ipairs(QBCore.Functions.GetPlayers()) do
            local Cop = QBCore.Functions.GetPlayer(v)
            if Cop and isPoliceJob(Cop.PlayerData.job.name) then
                TriggerClientEvent('ps-dispatch:client:sendAlert', v, {
                    dispatchCode = Config.Dispatch.dispatchCode or "10-99",
                    dispatchMessage = Config.Dispatch.dispatchMessage or "Suspicious drug sale reported",
                    dispatchSound = Config.Dispatch.dispatchSound or "ScannerAlert",
                    coords = coords,
                    radius = Config.Dispatch.radius or 50.0,
                    priority = Config.Dispatch.priority or 2,
                    job = Config.Dispatch.jobs or {"police", "sheriff", "state"}
                })
            end
        end
    end
end)