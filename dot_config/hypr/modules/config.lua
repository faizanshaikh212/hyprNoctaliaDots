hl.config({
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

-- Enable tearing master switch inside the general table
hl.config({
	general = {
		allow_tearing = true,
	},
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.config({
	-- Core XWayland rules to ensure proper background communication
	xwayland = {
		enabled = true,
		force_zero_scaling = true,
	},

	-- This block controls compositor-level input passing to unmapped X11 windows
	render = {
		-- Set to false if it exists, as explicit sync can sometimes drop background hooks on older drivers
		-- explicit_sync = false,
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		session_lock_xray = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
	},
})
