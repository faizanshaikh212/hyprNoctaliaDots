----------------
---- LAYOUT ----
----------------

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 2,
		resize_on_border = false,

		allow_tearing = false,

		layout = "scrolling",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 0.90,
		inactive_opacity = 0.80,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 4,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			brightness = 1,
			contrast = 0.85,
			vibrancy = 0.1696,
			noise = 0.01,
		},
	},

	animations = {
		enabled = true,
	},
})
