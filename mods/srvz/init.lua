if minetest.is_singleplayer() then
	return
end

svrz = {}

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)
local modpath = minetest.get_modpath(modname)
--Settings
local settings = Settings(modpath .. "/srvz.conf")
svrz.settings = {}
svrz.settings.reserved = tonumber(settings:get("reserved")) or 0

minetest.register_on_prejoinplayer(function(player)
	if minetest.check_player_privs(player, {server = true}) then
		return
	end
	local connected_players = minetest.get_connected_players()
	local max_players = tonumber(minetest.setting_get("max_users"))
	if max_players <= #connected_players + svrz.settings.reserved then
		local msg = S("Server full of players! Retry later.")
		return msg
	end
end)

minetest.register_privilege("moderator", {
    description = S("Can moderate the server"),
    give_to_singleplayer = true
})

--Tab of connected players in inventory

local function create_form()
	local player_cells = ""
	local player_faces = ""
	local i = 0
	for _, player in ipairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		local player_face
		if playerz.get_gender(player) ~= "" then
			local base_texture = playerz.get_base_texture_table(player)
			player_face = playerz.get_face(base_texture, 4.0, true)
		else
			player_face = "player_male_face.png"
		end
		--minetest.chat_send_all(player_face)
		if not(player_cells == "") then
			player_cells = player_cells..","
			player_faces = player_faces..","
		end
		player_faces = player_faces..tostring(i).."="..player_face
		player_cells = player_cells..tostring(i)..","..player_name
		i = i + 1
	end
	return [[
		label[0.25,0.25;]]..S("Connected Players")..":"..[[]
		tablecolumns[image,align=inline,]]..player_faces..[[;text]
		table[0.25,0.75;4,4;tab_players;]]..player_cells..[[;0]
	]]
end

sfinv.register_page("players", {
	title = S("Players"),
	get = function(self, player, context)
		return sfinv.make_formspec(player, context, create_form(), false)
	end,
})
