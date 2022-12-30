-- player/init.lua

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

dofile(modpath .. "/api.lua")
dofile(modpath .. "/base_texture.lua")
dofile(modpath .. "/damage.lua")
dofile(modpath .. "/cloths.lua")
dofile(modpath .. "/freeze.lua")
dofile(modpath .. "/hunger.lua")
dofile(modpath .. "/mermaid.lua")
dofile(modpath .. "/preview.lua")

-- Default player appearance
playerz.register_model("character.b3d", {
	animation_speed = 30,
	textures = {"player_skin.png", "blank.png"},
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
	colorize_skin = true,
	preview = {
		canvas_size = "10x18",
		skin = "player_preview.png",
		form_img_size = "2, 3.5" --width, height
	}
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
		playerz.set_player(player)
	end
	if playerz.is_mermaid(player) then
		playerz.set_mermaid(player)
	end
	-->REMOVE ON THE FIRST RELEASE
	local class = playerz.get_class(player)
	if not class then
		playerz.apply_class(player, playerz.set_class(player))
	end
	--<
	--Set Hunger Hudbar
	playerz.hb_add(player, hunger)
	-- Set formspec prepend
	local formspec = [[
		bgcolor[#303030;both]
		listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
		style_type[image_button;bgcolor=#ffffff55;bgimg=sfinv_bgimg.png;border=false]
		style_type[button;bgcolor=#ffffff;bgimg=sfinv_bgimg.png;border=false;bgimg_middle=2,2,14,14;padding=-14,-14,0,0]
	]]
	player:set_formspec_prepend(formspec)
	-- Set hotbar textures
	player:hud_set_hotbar_image("playerz_hotbar.png")
	player:hud_set_hotbar_selected_image("playerz_hotbar_selected.png")
	playerz.count = playerz.count + 1
	--Set Sky
	player:set_sky({sky_color={day_sky="#6ac4c4", day_horizon="#84d1d1"}})
	local inv = player:get_inventory()
	inv:set_size("craft", 4)
	inv:set_width("craft", samz.craft_width)
	--Enable Shadows
	--player:set_lighting({shadows={intensity = 0.33}})
end)
