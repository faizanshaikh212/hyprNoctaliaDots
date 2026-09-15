----------------------------
---- CUSTOM KEYBINDINGS ----
----------------------------

-- Toggle Mute button for discord only
-- NOTE: The NumPad "*" Asterisk key would not work for anything except discord if this is in use

hl.bind("KP_Multiply", hl.dsp.pass({ window = "class:^(discord)$" }))
