------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@144",
	position = "0x360",
	scale = "1",
})

hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@144", position = "1920x0", scale = "1" })

-- For gaming Main Monitor

-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@144", position = "1920x0", scale = "1" })

-- Workspaces 1-5 on External Main Monitor
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true, default_name = "一" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true, default_name = "二" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true, default_name = "三" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true, default_name = "四" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true, default_name = "五" })

-- Workspaces 6-10 on Built-In Laptop Monitor
hl.workspace_rule({ workspace = "6", monitor = "eDP-1", default_name = "六" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1", default_name = "七" })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1", default_name = "八" })
hl.workspace_rule({ workspace = "9", monitor = "eDP-1", default_name = "九" })
hl.workspace_rule({ workspace = "10", monitor = "eDP-1", default_name = "什" })
