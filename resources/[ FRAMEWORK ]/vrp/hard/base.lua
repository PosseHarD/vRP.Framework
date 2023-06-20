local cfg = {}

cfg.db = {
	driver = "oxmysql",
	host = "127.0.0.1",
	database = "hard.vrp",
	user = "root",
	password = ""
}

cfg.gaptitudes = {
	["physical"] = {
		_title = "Mochila",
		["strength"] = { "Forca",20,1900 }
	}
}

return cfg