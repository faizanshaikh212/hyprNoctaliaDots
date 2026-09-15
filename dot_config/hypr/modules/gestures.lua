------------------
---- GESTURES ----
------------------

-- 2-Finger Pinch In: Zoom into the cursor
hl.gesture({
	fingers = 2,
	direction = "pinchin",
	action = "cursor_zoom",
	zoom_level = 1.5,
	mode = "mult",
})

-- 2-Finger Pinch Out: Reset the viewport multiplier to 1.0 scale
hl.gesture({
	fingers = 2,
	direction = "pinchout",
	action = "cursor_zoom",
	zoom_level = 1.0,
	mode = "exact",
})

-- 3-Finger Swipe: Workspace Navigation
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "scroll_move",
})

hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "workspace",
})

-- 4-Finger Pinch In: Enable window float mode
hl.gesture({
	fingers = 4,
	direction = "pinchin",
	action = "float",
	mode = "float",
})

-- 4-Finger Pinch Out: Disable window float mode
hl.gesture({
	fingers = 4,
	direction = "pinchout",
	action = "float",
	mode = "tile",
})

-- 4-Finger Swipe Up: Fullscreen active window
hl.gesture({
	fingers = 4,
	direction = "up",
	action = "fullscreen",
})

-- 4-Finger Swipe Down: Toggle Special Workspace
hl.gesture({
	fingers = 4,
	direction = "down",
	action = "special",
	workspace_name = "scratchpad",
	disable_inhibit = true,
})

---------------------------------------
---- SCROLL OVERVIEW PLUGIN CONFIG ----
---------------------------------------

if hl.plugin and hl.plugin.scrolloverview then
	hl.plugin.scrolloverview.configure({
		gesture_distance = 300,
		scale = 0.5,
	})

	-- SUPER + 3-finger vertical swipe to invoke overview
	hl.plugin.scrolloverview.gesture({
		fingers = 3,
		direction = "vertical",
		mods = "SUPER",
	})
end
