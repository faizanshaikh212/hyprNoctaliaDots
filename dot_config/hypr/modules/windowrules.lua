--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

--Noctalia
hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	blur = true,
	ignore_alpha = 0.2,
	blur_popups = true,
})

hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

-- Wlogout
hl.layer_rule({
	match = {
		namespace = "logout_dialog",
	},
	blur = true,
})

-- Pulsemixer floating window
hl.window_rule({
	match = {
		class = "^(.*pulsemixer.*)$",
	},
	float = true,
	size = { 720, 600 },
	move = { "49%", 10 },
	pin = true,
})

-- Pavucontrol floating window
hl.window_rule({
	match = {
		class = "^(.*pavucontrol.*)$",
	},
	float = true,
	size = { 720, 600 },
	center = true,
	pin = true,
})

-- Rofi background blur
hl.layer_rule({
	match = { namespace = "rofi" },
	blur = true,
	ignore_alpha = 0.5,
})

-- Swaync background blur
hl.layer_rule({
	match = { namespace = "swaync-control-center" },
	blur = true,
	ignore_alpha = 0.7,
})

hl.window_rule({
	match = {
		class = "^(nemo)$",
		title = ".*[Oo]pen.*",
	},
	float = true,
	size = { 720, 800 },
	center = true,
	pin = true,
})

-- Block windows from screenshare/screenshot when tagged
hl.window_rule({ match = { tag = "windowPrivate" }, no_screen_share = true, border_color = "rgb(f0a8ad)" })

-- toggle transperency/blur when tagged
hl.window_rule({ match = { tag = "windowOpacity" }, no_dim = true, no_blur = true, opaque = true, border_color = "rgb(a8def0)" })
