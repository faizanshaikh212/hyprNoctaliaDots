-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Colors

-- local colors = require("colors.colors-matugen")

-- Main Modules
require("modules.animations")
require("modules.autostart")
require("modules.binds")
require("modules.config")
require("modules.env")
require("modules.gestures")
require("modules.input")
require("modules.layout")
require("modules.monitors")
require("modules.permissions")
require("modules.windowrules")

-- Custom Modules
require("modules.custom.binds")
require("modules.custom.windowrules")
require("modules.gaming")

-- Plugins
require("plugins.dynamic_cursor")
require("plugins.scroll_overview")


-- For Noctalia Color templates
require("noctalia").apply_theme()
