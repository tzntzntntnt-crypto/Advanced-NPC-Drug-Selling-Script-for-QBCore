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

Config = {}

Config.Drugs = {
    { name = 'Joint', item = 'joint' },
    { name = 'Cocaine', item = 'baggy_cocaine' },
    { name = 'meth_blue', item = 'meth_blue' }
}

Config.PriceRange = {
    joint = { min = 100, max = 150 },
    baggy_cocaine = { min = 150, max = 210 },
    meth_blue = { min = 350, max = 450 }
}

Config.PoliceJobs = { "police", "sheriff", "state" }

Config.OfferMin = 1
Config.OfferMax = 20
Config.NPCRefuseChance = 25
Config.Cooldown = 30000
Config.MinPolice = 1
Config.TargetDistance = 2.5

Config.HighPayMultiplier = 2
Config.HighPayZone = {
    coords = vector3(226.3, 208.32, 105.53),
    radius = 100.0,
}

Config.AlertChance = 30
Config.AlertRadius = 50.0

Config.Messages = {
    notInterested = {
        "Nah, not interested.",
        "No thanks, move along.",
        "You tryna get me locked up?",
        "Not today, man."
    },
    selling = {
        "Making the deal...",
        "Handing over the bag...",
        "Completing transaction..."
    },
    policeBlocked = "Police cannot sell drugs!",
    noPoliceOnline = "Not enough police online to sell drugs.",
    noInventory    = "NPC wants %s but you don't have any.",
    notEnoughItem  = "You don't have enough %s to sell.",
    saleSuccess    = "Sold %dx %s for $%d.",
}

Config.Dispatch = {
    enabled = true,
    dispatchCode = "10-99",
    dispatchMessage = "Suspicious drug sale reported",
    dispatchSound = "ScannerAlert",
    radius = 50.0,
    priority = 2,
    jobs = { "police", "sheriff", "state" }
}

-- Blacklisted NPCs - Add NPC model hashes here to disallow selling to them
Config.BlacklistedNPCs = {
    GetHashKey('s_m_m_highsec_01'),
    GetHashKey('s_m_m_doctor_01'),
    GetHashKey('a_m_m_business_01'),
    GetHashKey('a_m_y_business_01'),
    GetHashKey('a_m_m_farmer_01'),
    GetHashKey('s_m_y_dealer_01'),
    GetHashKey('g_m_m_armboss_01'),
    GetHashKey('a_m_m_skater_01'),
    GetHashKey('g_m_y_ballasout_01'),
    GetHashKey('mp_m_shopkeep_01'),
    GetHashKey('a_m_m_soucent_02'),
    GetHashKey('a_f_y_eastsa_01'),
    GetHashKey('mp_m_waremech_01'),
    GetHashKey('s_m_y_ammucity_01'),
    -- add more NPC model hashes as needed
}
