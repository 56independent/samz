local S = ...

local WATER_ALPHA = "^[opacity:" .. 230
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

minetest.register_node("nodez:river_water_source", {
	description = S("River Water Source").."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	waving = 3,
	tiles = { "nodez_river_water.png"..WATER_COLORIZE..WATER_ALPHA },
	special_tiles = {
		{name = "nodez_river_water.png"..WATER_COLORIZE..WATER_ALPHA, backface_culling = false},
		{name = "nodez_river_water.png"..WATER_COLORIZE..WATER_ALPHA, backface_culling = true},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "nodez:river_water_flowing",
	liquid_alternative_source = "nodez:river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, },
	sounds = sound.water(),
})

minetest.register_node("nodez:river_water_flowing", {
	description = S("Flowing River Water").."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"nodez_river_water_flowing.png"..WATER_COLORIZE..WATER_ALPHA},
	special_tiles = {
		{name = "nodez_river_water_flowing.png"..WATER_COLORIZE..WATER_ALPHA,
			backface_culling = false},
		{name = "nodez_river_water_flowing.png"..WATER_COLORIZE..WATER_ALPHA,
			backface_culling = false},
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
	liquid_alternative_flowing = "nodez:river_water_flowing",
	liquid_alternative_source = "nodez:river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, },
	sounds = sound.water(),
})

--Muddy Swamp Water

minetest.register_node("nodez:muddy_water_source", {
	description = S("Muddy Water Source"),
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "nodez_water_animated.png"..WATER_ALPHA..WATER_SWAMP_COLORIZE,
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "nodez_water_animated.png"..WATER_ALPHA..WATER_SWAMP_COLORIZE,
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	alpha = 212,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "nodez:muddy_water_flowing",
	liquid_alternative_source = "nodez:muddy_water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 191, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = sound.water(),
})

minetest.register_node("nodez:muddy_water_flowing", {
	description = S("Flowing Muddy Water"),
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"nodez_water.png"..WATER_ALPHA..WATER_SWAMP_COLORIZE},
	special_tiles = {
		{
			name = "nodez_water_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "nodez_water_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	alpha = 212,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nodez:muddy_water_flowing",
	liquid_alternative_source = "nodez:muddy_water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 191, r = 30, g = 90, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = sound.water(),
})

--Ice

minetest.register_node("nodez:ice", {
	description = S("Ice"),
	tiles = {"nodez_ice.png"},
	is_ground_content = false,
	drawtype = "glasslike",
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = sound.ice(),
})
