local S = ...

local WATER_ALPHA = "^[opacity:" .. 208
local WATER_VISC = 1
local WATER_COLORIZE = "^[colorize:#628df0:192"
local WATER_SWAMP_COLORIZE = "^[colorize:#7d8f35:128"

minetest.register_node("nodez:water_source", {
	description = S("Water Source").."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	waving = 3,
	tiles = {{
		    name = "nodez_water_animated.png"..WATER_COLORIZE..WATER_ALPHA,
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0},
		    backface_culling = true,
	}},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "nodez:water_flowing",
	liquid_alternative_source = "nodez:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3},
	sounds = sound.water(),
})

minetest.register_node("nodez:water_flowing", {
	description = S("Flowing Water").."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"nodez_water_flowing.png"},
	special_tiles = {
		{
			name = "nodez_water_flowing.png"..WATER_COLORIZE..WATER_ALPHA,
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "nodez_water_flowing.png"..WATER_COLORIZE..WATER_ALPHA,
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nodez:water_flowing",
	liquid_alternative_source = "nodez:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3},
	sounds = sound.water(),
})

--Muddy Swamp Water


minetest.register_node("nodez:muddy_water_source", {
	description = S("Muddy Water Source").."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	waving = 3,
	tiles = {{
		    name = "nodez_water_animated.png"..WATER_SWAMP_COLORIZE..WATER_ALPHA,
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 4.0},
		    backface_culling = true,
	}},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "nodez:muddy_water_flowing",
	liquid_alternative_source = "nodez:muddy_water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3},
	sounds = sound.water(),
})

minetest.register_node("nodez:muddy_water_flowing", {
	description = S("Muddy Flowing Water").."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"nodez_water_flowing.png"},
	special_tiles = {
		{
			name = "nodez_water_flowing.png"..WATER_SWAMP_COLORIZE..WATER_ALPHA,
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "nodez_water_flowing.png"..WATER_SWAMP_COLORIZE..WATER_ALPHA,
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nodez:muddy_water_flowing",
	liquid_alternative_source = "nodez:muddy_water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3},
	sounds = sound.water(),
})

--Snow and Ice

minetest.register_node("nodez:snow", {
	description = S("Snow"),
	tiles = {"nodez_snow.png"},
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, snow = 1},
	sounds = sound.snow(),

	on_construct = function(pos)
		if helper.node_is_dirt(pos, -1) then
			pos.y = pos.y - 1
			minetest.set_node(pos, {name = "nodez:dirt_with_snow"})
		end
	end,
})

minetest.register_node("nodez:snow_block", {
	description = S("Snow Block"),
	tiles = {"nodez_snow.png"},
	is_ground_content = false,
	drawtype = "normal",
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 2, build = 1},
	sounds = sound.ice(),
})

throwz.register_throw("nodez:snowball", {
	type = "normal",
	description = S("Snowball"),
	inventory_image = "nodez_snowball.png",
	wield_image = "nodez_snowball.png",
	strength = 10,
	throw_damage = 0.5,
	throw_sounds = {
		max_hear_distance = 10,
		gain = 0.6,
	},
	drop = "nodez:snow",
	recipe ={
		{"nodez:snow_block", ""},
		{"", ""}
	}
})

minetest.register_node("nodez:ice", {
	description = S("Ice"),
	tiles = {"nodez_ice.png"},
	is_ground_content = false,
	drawtype = "glasslike",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	groups = {cracky = 3, cools_lava = 1, slippery = 3, build = 1},
	sounds = sound.ice(),
})

minetest.register_node("nodez:floe", {
	description = S("Ice Floe"),
	tiles = {"nodez_ice.png"},
	paramtype = "light",
	use_texture_alpha = "blend",
	buildable_to = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
		},
	},
	groups = {crumbly = 3, ice = 1},
	sounds = sound.ice(),
})

--Salt

minetest.register_craftitem("nodez:salt", {
	description = S("Salt"),
	inventory_image = "nodez_salt.png",
	groups = {food=1, salt=1}
})

minetest.register_craft({
	type = "cooking",
	output = "nodez:salt",
	recipe = "group:water",
	burntime = 4,
})
