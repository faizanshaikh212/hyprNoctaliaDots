-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	-- Export variables to systemd
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")

	-- Start hyprpm plugins
	hl.exec_cmd("hyprpm reload -n")

	-- Start GPU Screen Recorder
	hl.exec_cmd("gsr-ui")

	-- Noctalia
	hl.exec_cmd("noctalia")

	-- Local music
	hl.exec_cmd("systemctl --user start mpd")
	hl.exec_cmd("systemctl --user start mpd-mpris")

	-- Clipboard
	hl.exec_cmd("wl-paste --type text --watch cliphist store -max-items 500")
	hl.exec_cmd("wl-paste --type image --watch cliphist store -max-items 100")

	-- Sync and reset the cursor animation state right after plugins load
	hl.exec_cmd(os.getenv("HOME") .. "/.config/hypr/scripts/disable_cursor_anims startup")
end)
