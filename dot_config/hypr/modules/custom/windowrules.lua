local noctalia = require("noctalia")
----------------------------
---- CUSTOM WINDOWRULES ----
----------------------------

-- Floating Numbat Scientific Calculator
hl.window_rule({
	name = "numbat_scratchpad",
	match = { class = "numbat-calc" },
	float = true,
	size = { "monitor_w*0.15", "monitor_h*0.5" },
	move = { "monitor_w*0.425", "monitor_h*0.455" },
})

-- Loupe
hl.window_rule({
	match = { class = "org.gnome.Loupe" },
	center = true,
	float = true,
	size = { "monitor_w*0.8", "monitor_h*0.8" },	
})


-- Discord Configurations

-- Open Discord in Workspace-6, Silent Mode
hl.window_rule({
	match = { class = "^(discord)$" },
	workspace = "6 silent",
})

-- Discord Updater window in center
hl.window_rule({
	match = {
		class = "^(discord)$",
		title = "^(Discord|Discord Updater)$",
	},
	center = true,
})

-- Remove window decorations, Match ANY channel/stream starting with specified symbols
hl.window_rule({
	match = {
		class = "^(discord)$",
		title = "^[🔊🧊💤].*$",
	},
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})
-- Standard behaviour, with decorations
hl.window_rule({
	match = {
		class = "^(discord)$",
		title = "^(?![🔊🧊💤]).*$",
	},
})

-- Steam Configurations

-- Float and center 
hl.window_rule({
	match = {
		class = "^(steam)$",
		title = "^(Friends List)$",
	},
	center = true,
	float = true,
	size = { 350, 800 },
})


-- Fix Steam sizing issues
hl.window_rule({
	match = {
		class = "^(steam)$",
	},
	suppress_event = "maximize",
})


-- No Man's Sky Configuration
hl.window_rule({
	match = {
		class = ".*[Nn]o Man's Sky.*|.*steam_app_275850.*",
	},
	workspace = "1 silent",
	fullscreen = true,
	confine_pointer = true,
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- CS2 Configuration
hl.window_rule({
	match = {
		class = ".*cs2.*|.*steam_app_730.*",
	},
	fullscreen = true,
	confine_pointer = true,
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Sea Of Thieves Configuration
hl.window_rule({
	match = {
		class = ".*sotgame.exe.*|.*steam_app_1172620.*",
	},
	fullscreen = true,
	confine_pointer = true,
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Combat Master Configuration
hl.window_rule({
	match = {
		class = ".*CombatMaster.x86_64.*",
	},
	fullscreen = true,
	confine_pointer = true,
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- R.E.P.O. Configuration
hl.window_rule({
	match = {
		class = ".*steam_app_480.*",
	},
	fullscreen = true,
	confine_pointer = true,
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Minecraft Configuration
hl.window_rule({
	match = {
		-- class = ".*[Mm]inecraft.*",
	},
	fullscreen = true,
	confine_pointer = true,
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Zen Browser(Private Window) Configuration
hl.window_rule({
	match = {
		class = "^(zen)$",
		title = "^(.*)(Zen Browser Private Browsing)$",
	},
	no_screen_share = true,
	border_color = "rgb(f0a8ad)",
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Zen Browser(Messaging WebApps) Configuration
hl.window_rule({
	match = {
		class = ".*[Zz]en.*",
		title = ".*[Ww]hatsApp.*|.*[Dd]iscord.*",
	},
	no_screen_share = true,
	border_color = "rgb(f0a8ad)",
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Nemo(Personal Files) Configuration
hl.window_rule({
	match = {
		class = "^(nemo)$",
		title = ".*[Dd]ocument.*|.*[Ee]xternal.*|.*[Ss]creenshot.*|.*[Pp]roject.*",
	},
	no_screen_share = true,
	border_color = "rgb(f0a8ad)",
})

-- yazi(Personal Files) Configuration
hl.window_rule({
	match = {
		class = "^(kitty)$",
		title = ".*[Yy]azi: [Ff]aizan.*|.*[Yy]azi: [Dd]ocument.*|.*[Yy]azi: [Ee]xternal.*|.*[Yy]azi: [Ss]creenshot.*",
	},
	no_screen_share = true,
	border_color = "rgb(f0a8ad)",
})

-- Bitwarden Configuration
hl.window_rule({
	match = {
		class = ".*[Bb]itwarden.*",
	},
	no_screen_share = true,
	border_color = "rgb(f0a8ad)",
})

-- Unreal Engine Configuration
hl.window_rule({
	match = {
		class = ".*Unreal.*",
	},
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
})

-- Unreal Engine Diversion_Version-Control
hl.window_rule({
	match = {
		title = ".*Diversion.*",
	},
	float = true,
})

-- Swash Screenshot Tool
hl.window_rule({
	match = {
		title = ".*[Ss]wash.*",
	},
	float = true,
})

-- Unreal Game Preview
hl.window_rule({
	match = {
		title = ".*RadGuys Preview.*",
	},
	opacity = 1.0,
	no_dim = true,
	no_blur = true,
	opaque = true,
	float = true,
	center = true,
	size = { 1280, 720 }
})
