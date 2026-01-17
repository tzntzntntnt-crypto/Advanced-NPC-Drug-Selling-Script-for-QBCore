Elevate your FiveM server with this Advanced NPC Drug Selling Script for QBCore! This script is designed for immersive, safe, and optimized drug-selling interactions with AI pedestrians while keeping gameplay balanced and server performance smooth.

💎 Key Features:

Dynamic NPC Interaction

Sell drugs to human NPCs in the world using qb-target.

NPCs may accept or refuse your offer based on configurable probabilities.

Automatic cooldown for NPCs to prevent repetitive selling exploits.

Blacklist specific NPCs (shopkeepers, doctors, police, gang leaders, etc.) to avoid selling to undesired characters.

Realistic Selling Mechanics

Randomized offers with configurable min/max quantity.

Dynamic pricing based on location, including High-Pay Zones with configurable multipliers.

Animated selling interactions using progress bars and realistic handover animations.

Server-Side Security & Checks

Checks for police presence before allowing sales.

Server-side validation to prevent cheating (no selling without items or bypassing police checks).

Police cannot sell drugs, fully preventing job exploits.

Optional Dispatch Alerts

Integrated with ps-dispatch (or any dispatch system) to alert police of suspicious activity.

Configurable alert chance, radius, priority, and custom message.

Fully Configurable

Add new drugs, set price ranges, define blacklisted NPCs.

Customize cooldown, refusal chance, police requirements, high-pay zones, and more.

Supports QBCore items and cash system.

Optimized for Performance

Minimal server and client footprint.

Efficient NPC checks and cooldowns to prevent server lag.

Works globally with all NPCs in the world without causing performance drops.

Safe & Reliable

Server-side validation prevents exploits and duplication.

Tested for QBCore 2.0+.

Error handling included for missing items, dead NPCs, or invalid entities.

🎛️ Customization Examples:

Easily add new drugs: Config.Drugs = {{name='Meth', item='meth_blue'}}

Set NPC refusal chance: Config.NPCRefuseChance = 25

Configure high-pay zones: Config.HighPayZone = { coords = vector3(200, 300, 100), radius = 100 }

Enable or disable police dispatch alerts: Config.Dispatch.enabled = true

🔧 Installation:

Place the resource in your resources folder.

Add ensure drugsell to your server.cfg.

Make sure qb-core and qb-target are installed.

Customize your configuration in config.lua.

✅ Why Choose This Script:

Fully ready-to-use for QBCore servers.

Immersive and fun roleplay mechanics.

Safe from exploits and cheating.

Lightweight and optimized for any server size.

Easy to configure and extend.

💬 Changelog / Notes:

Version 1.0 – Initial release.

Optimized NPC detection, cooldown system, and server-side security.

Added High-Pay Zones and optional dispatch alerts.

🔗 Requirements:

QBCore Framework

qb-target

Optional: ps-dispatch for police alerts

📧 Email: tzntzntntnt@gmail.com

💬 Discord: Coming soon! I’ll share the server link shortly.
