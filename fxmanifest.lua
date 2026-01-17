
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

fx_version 'cerulean'
game 'gta5'

author 'gizffzufut'
description 'QBCore Drug NPC Selling - OxLib Version'
version '1.6.0'

shared_scripts {
    '@ox_lib/init.lua', -- Adds ox_lib support
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'ox_lib', -- Added ox_lib
    'ps-dispatch'
}