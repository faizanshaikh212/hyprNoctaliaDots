-- Local Function
local M = {}


--------------------
---- GAMES LIST ----
--------------------

local games = {
	"steam_app",
	"cs2",
	"minecraft",
	"no-mans-sky",
	"cyberpunk"
}


---------------------
---- SHARED APPS ----
---------------------

local shared_apps = {
	"kitty",
	"nemo",
	"btop",
	"missioncenter",
}


-----------------------
---- MATCH CLASSES ----
-----------------------

local function matches_class(window, patterns)

	if not window then
		return false
	end

	-- Check both `window.class` and `window.initial_class`
	local classes = {
		window.class,
		window.initial_class,
	}

	for _, class in ipairs(classes) do

		if class then

			class = string.lower(class)

			for _, pattern in ipairs(patterns) do

				pattern = string.lower(pattern)

				if string.find(class, pattern, 1, true) then
					return true
				end

			end
		end
	end

	return false
end


----------------------------
---- DETECT GAME WINDOW ----
----------------------------

local function is_game(window)

	return matches_class(window, games)

end


------------------------------
---- GAME WORKSPACE CHECK ----
------------------------------

local function workspace_has_game(workspace, excluded_window)

	if not workspace then
		return false
	end

	local windows = hl.get_workspace_windows(workspace.id)

	for _, window in ipairs(windows) do

		-- Optionally ignore one specific window
		if window ~= excluded_window then

			if is_game(window) then
				return true
			end

		end

	end

	return false
end


------------------------------------
---- FIND FIRST EMPTY WORKSPACE ----
------------------------------------

local function find_empty_workspace(current_workspace_id, excluded_window)

	local workspaces = hl.get_workspaces()


	----------------------------------------
	---- PRIORITY 1: ORIGINAL WORKSPACE ----
	----------------------------------------

	-- If workspace where window was originally opened, contains no other windows, keep window there
	for _, workspace in ipairs(workspaces) do

		if workspace.id == current_workspace_id then

			local windows = hl.get_workspace_windows(workspace.id)

			local has_other_window = false

			for _, window in ipairs(windows) do

				if window ~= excluded_window then
					has_other_window = true
					break
				end

			end

			if not has_other_window then
				return workspace.id
			end

		end

	end


	-------------------------------------------
	---- PRIORITY 2: OTHER EMPTY WORKSPACE ----
	-------------------------------------------

	-- If original workspace isn't empty, find first completely empty workspace
	for _, workspace in ipairs(workspaces) do

		if workspace.id ~= current_workspace_id then

			local windows = hl.get_workspace_windows(workspace.id)

			-- Workspace must be completely empty
			if #windows == 0 then
				return workspace.id
			end

		end

	end

	return nil
end


---------------------------------------
---- FIND FIRST NON-GAME WORKSPACE ----
---------------------------------------

local function find_shared_workspace(current_workspace_id)

	local workspaces = hl.get_workspaces()

	for _, workspace in ipairs(workspaces) do

		-- Never use the workspace the window was originally opened on
		if workspace.id ~= current_workspace_id then

			-- Shared apps can join existing normal applications, but never a game workspace
			if not workspace_has_game(workspace) then
				return workspace.id
			end

		end

	end

	return nil
end


----------------------------------------
---- MOVE WINDOW TO EMPTY WORKSPACE ----
----------------------------------------

local function move_to_empty(window, current_workspace_id)

	local target = find_empty_workspace(
		current_workspace_id,
		window
	)

	if not target then
		return
	end


	-- If target is already window's current workspace, there is nothing to move.
	if target == current_workspace_id then
		hl.dispatch(
			hl.dsp.focus({
				window = window,
			})
		)

		return
	end


	hl.dispatch(
		hl.dsp.window.move({
			workspace = tostring(target),
			follow = false,
			window = window,
		})
	)

	hl.dispatch(
		hl.dsp.focus({
			window = window,
		})
	)
end


-----------------------------------------
---- MOVE WINDOW TO SHARED WORKSPACE ----
-----------------------------------------

local function move_to_shared(window, workspace_id)

	hl.dispatch(
		hl.dsp.window.move({
			workspace = tostring(workspace_id),
			follow = false,
			window = window,
		})
	)

	hl.dispatch(
		hl.dsp.focus({
			window = window,
		})
	)
end


---------------------------------
---- WINDOW OPEN EVENT RULES ----
---------------------------------

hl.on("window.open", function(window)

	-----------------------------
	---- GET SPAWN WORKSPACE ----
	-----------------------------

	local workspace = window.workspace

	if not workspace then
		return
	end


	----------------------------------
	---- RULE 1: DEFAULT BEHAVIOR ----
	----------------------------------

	-- If the workspace doesn't contain a game, preserve normal behavior
	if not workspace_has_game(workspace) then
		return
	end


	-----------------------------
	---- RULE 2: GAME WINDOW ----
	-----------------------------

	if is_game(window) then

		-- Un-comment to enable: Opening Game window in Focused Workspace if empty

		-- if not workspace_has_game(workspace, window) then
		-- 	return
		-- end

		move_to_empty(window, workspace.id)

		return
	end


	-------------------------------------
	---- RULE 3: SHARED APPLICATIONS ----
	-------------------------------------

	if matches_class(window, shared_apps) then

		local target = find_shared_workspace(workspace.id)

		if target then

			move_to_shared(window, target)

		else

			-- If no non-game workspace exists, fall back to first empty workspace
			move_to_empty(window, workspace.id)

		end

		return
	end


	-----------------------------------------
	---- RULE 4: NON-SHARED APPLICATIONS ----
	-----------------------------------------

	-- Anything else opened over a game goes to the first completely empty workspace
	move_to_empty(window, workspace.id)

end)


return M
