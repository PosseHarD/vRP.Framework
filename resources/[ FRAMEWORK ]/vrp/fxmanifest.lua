fx_version 'adamant'
game 'gta5'

author 'Felipe Alarcon'
contact 'https://hardnetwork.com.br'

ui_page "gui/index.html"

server_scripts { 
	"lib/utils.lua",

	"base.lua",
	"queue.lua",

	"hard/base.lua",
	"hard/groups.lua",
	"hard/items.lua",
	"hard/player_state.lua",
	"hard/vehicles.lua",
	"hard/sanitizes.lua",
	"hard/blips.lua",
	"hard/skinshops.lua",

	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/business.lua",
	"modules/survival.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/prepare.lua",
	"modules/identity.lua",
	"modules/home.lua",
	"modules/home_components.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
	"modules/basic_skinshop.lua",
	"modules/cloakroom.lua"
}

client_scripts {
	"lib/utils.lua",

	"hard/base.lua",
	"hard/groups.lua",
	"hard/items.lua",
	"hard/player_state.lua",
	"hard/vehicles.lua",
	"hard/sanitizes.lua",
	"hard/blips.lua",
	"hard/skinshops.lua",

	"client/base.lua",
	"client/basic_garage.lua",
	"client/iplloader.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/peds.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/notify.lua",
	"client/identity.lua",
	"client/police.lua"
}

files {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",
	"gui/index.html",
	"gui/design.css",
	"gui/main.js",
	"gui/Menu.js",
	"gui/WPrompt.js",
	"gui/RequestManager.js",
	"gui/Div.js",
	"gui/dynamic_classes.js",
	"gui/bebas.ttf"
}

server_export "AddPriority"
server_export "RemovePriority"