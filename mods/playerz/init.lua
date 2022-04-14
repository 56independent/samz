-- player/init.lua

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath .. "/api.lua")
dofile(modpath .. "/base_texture.lua")
dofile(modpath .. "/damage.lua")
dofile(modpath .. "/cloths.lua")
dofile(modpath .. "/freeze.lua")
dofile(modpath .. "/hunger.lua")

-- Default player appearance
playerz.register_model("character.b3d", {
	animation_speed = 30,
	textures = {"character.png"},
	animations = {
		-- Standard animations.
		stand = {x = 0,   y = 79},
		lay = {x = 162, y = 166},
		walk = {x = 168, y = 187},
		mine = {x = 189, y = 198},
		walk_mine = {x = 200, y = 219},
		sit = {x = 81,  y = 160},
		swin = {x = 232, y = 280},
		swin_mine = {x = 281, y = 305},
		swin_and_mine = {x = 306, y = 330},
		swin_stand = {x = 232, y = 232},
	},
	collisionbox = {-0.28125, 0.0, -0.28125, 0.28125, 1.5, 0.28125},
	stepheight = 0.6,
	eye_height = 1.47,
})

-- Update appearance when the player joins
minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	playerz.player_attached[player_name] = false
	local gender = playerz.get_gender(player)
	--Set some vars
	playerz.set_status(player, "normal")
	if minetest.get_modpath("ptol") ~= nil then
		if player:get_meta():get_int("ptol:level") == 0 then
			player:get_meta():set_int("ptol:level", 4)
		end
	end
	local hunger
	if gender == "" then --Initial values as gender, hunger
		hunger = playerz.init_hunger(player)
		playerz.select_gender(player_name) --select the gender
	else
		hunger = playerz.load_hunger(player)
		local cloth = playerz.compose_cloth(player)
		playerz.registered_models[playerz.get_gender_model(gender)].textures[1] = cloth
		playerz.set_model(player, playerz.get_gender_model(gender))
	end
	--Set Hunger Hudbar
	playerz.hb_add(player, hunger)
	-- Set formspec prepend
	local formspec = [[
		bgcolor[#303030;both]
		listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
	]]
	player:set_formspec_prepend(formspec)
	-- Set hotbar textures
	player:hud_set_hotbar_image("playerz_hotbar.png")
	player:hud_set_hotbar_selected_image("playerz_hotbar_selected.png")
	playerz.count = playerz.count + 1
	--Set Sky
	player:set_sky({sky_color={day_sky="#6ac4c4", day_horizon="#84d1d1"}})
	--Enable Shadows
	--player:set_lighting({shadows={intensity = 0.33}})
end)
