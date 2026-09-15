--------------------------
---- DEFINE SHORTCUTS ----
--------------------------

-- Important
local mainMod = "SUPER"
local shiftMod = "SUPER + SHIFT"
local noct = "noctalia msg "

-- Noctalia
local altTab = noct .. "window-switcher"
local clipboard = noct .. "panel-toggle clipboard"
local calculator = noct .. "panel-toggle yuuto/calculator:panel"
local menu = noct .. "panel-toggle launcher"
local settings = noct .. "settings-toggle"
local powerMenu = noct .. "panel-toggle session"
local wallpaperMenu = noct .. "panel-toggle wallpaper"
local screenshot = noct .. "screenshot-region"

-- Programs
local terminal = 'kitty'
local no_pilot = [[kitty --session ~/.config/kitty/workspaces/DefaultWorkspace.conf]]
local sys_mon = "missioncenter"
local fileManager = "kitty -e yazi -- --show-hidden"
local fileManager2 = "nemo"
local menu_emoji = [[rofi -modi emoji -show emoji -emoji-format '{emoji}' -theme ~/.config/rofi/themes/emoji_menu.rasi]]
local browser = "zen-browser"


------------------------
---- DEFINE SCRIPTS ----
------------------------

local toggle_charging = "~/.config/hypr/scripts/toggle_battery"
local qr_scan = "~/.config/hypr/scripts/qr_scan"


---------------------------------
---- APPLICATION KEYBINDINGS ----
---------------------------------

-- Open terminal
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))

-- Open Custom no_pilot
hl.bind(shiftMod .. " + code:201", hl.dsp.exec_cmd(no_pilot))

-- Open Mission Center
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(sys_mon))

-- Open file manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Open alternate file manager
hl.bind(shiftMod .. " + E", hl.dsp.exec_cmd(fileManager2))

-- Open Wallpaper daemon
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(wallpaperMenu))

-- Open application launcher menu
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

-- Open Settings
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd(settings))

-- Open emoji menu
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(menu_emoji))

-- Open Browser
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

-- Open Private Browser
hl.bind(shiftMod .. " + B", hl.dsp.exec_cmd(browser .. " --private-window"))

----------------------------
---- TOOLS KEYBINDINGS ----
----------------------------

-- QR Code scan using zbar
hl.bind(shiftMod .. " + W", hl.dsp.exec_cmd(qr_scan))

-- Open Calculator
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(calculator))

-- Open Clipboard Menu
hl.bind(mainMod .. " + v", hl.dsp.exec_cmd(clipboard))

-- Alt+Tab
hl.bind("ALT + Tab", hl.dsp.exec_cmd(altTab))

-- Screenshot
hl.bind(shiftMod .. " + S", hl.dsp.exec_cmd(screenshot))

----------------------------
---- SYSTEM KEYBINDINGS ----
----------------------------

-- Scroll Overview
hl.bind(mainMod .. " + W", function()
	hl.plugin.scrolloverview.overview("toggle all")
end)

-- Toggle Window screencast blocking
hl.bind(shiftMod .. " + A", function()
	hl.dispatch(hl.dsp.window.tag({ tag = "windowPrivate" }))
end)

-- Toggle Window opacity
hl.bind(mainMod .. " + A", function()
	hl.dispatch(hl.dsp.window.tag({ tag = "windowOpacity" }))
end)

-- Wlogout Menu
hl.bind(shiftMod .. " + X", hl.dsp.exec_cmd(powerMenu))

-- Logout/Open Login screen fallback
hl.bind(shiftMod .. " + M", hl.dsp.exec_cmd("loginctl kill-session $XDG_SESSION_ID"))

-- Window pseudo
hl.bind(shiftMod .. " + O + P", hl.dsp.window.pseudo())

-- Toggle Window Float
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

--Toggle battery charge_type
hl.bind(shiftMod .. " + C", hl.dsp.exec_cmd(toggle_charging))

--Display Monitor Menu
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/hypr/scripts/monitor_menu"))

-------------------------------
---- WORKSPACE KEYBINDINGS ----
-------------------------------

-- Close open window
hl.bind(shiftMod .. " + Q", function()
    local active = hl.get_active_window()
        if active and active.class and string.find(active.class, "Unreal") then
        return 
    else
        hl.dispatch(hl.dsp.window.close())
    end
end)


-- Toggle Split in dwindle layout only
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move open windows with shiftMod + arrow keys
hl.bind(shiftMod .. " + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(shiftMod .. " + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(shiftMod .. " + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(shiftMod .. " + down", hl.dsp.window.swap({ direction = "down" }))

hl.bind(shiftMod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(shiftMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(shiftMod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(shiftMod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))

-- Workspaces Setup
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	-- Switch workspaces with "mainMod + [0-9]"
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	-- Move active window to a workspace with "shiftMod + [0-9]""
	hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("magic"))
hl.bind(shiftMod .. " + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

----------------------------
---- LAPTOP KEYBINDINGS ----
----------------------------

-- Laptop multimedia keys for volume and LCD brightness

-- Volume (+)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)

-- Volume (-)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

-- Volume SPEAKER-OUTPUT_MUTE
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

-- Volume MIC-INPUT_MUTE
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Monitor Brightness (+)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })

-- Monitor Brightness (-)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Multimedia Play
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Multimedia Pause
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Multimedia Previous
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Multimedia Next
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
