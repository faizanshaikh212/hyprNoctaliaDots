-- ~/.config/yazi/init.lua

-- Removed starship from here
require("simple-status"):setup()

function Linemode:size_and_mtime()
	local time = math.floor(self._file.cha.mtime or 0)
	if time == 0 then
		time = ""
	elseif os.date("%Y", time) == os.date("%Y") then
		time = os.date("%b %d %H:%M", time)
	else
		time = os.date("%b %d  %Y", time)
	end

	local size = self._file:size()
	local size_str = size and ya.readable_size(size) or "-"

	return ui.Line(string.format("%s %s", size_str, time))
end

require("full-border"):setup()

require("smart-enter"):setup({
	open_multi = true,
})
