local S = ...

local WATER_ALPHA = "^[opacity:" .. 210
local WATER_VISC = 1

minetest.register_node("nodez:water_source", {
	description = S("Water Source").."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	waving = 3,
	tiles = {"nodez_water.png"..WATER_ALPHA},
	special_tiles = {
		{name = "nodez_water.png"..WATER_ALPHA, backface_culling = false},
		{name = "nodez_water.png"..WATER_ALPHA, backface_culling = true},
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
	liquid_alternative_flowing = "nodez:water_flowing",
	liquid_alternative_source = "nodez:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3},
})

minetest.register_node("nodez:water_flowing", {
	description = S("Flowing Water").."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"nodez_water_flowing.png"},
	special_tiles = {
		{name = "nodez_water_flowing.png"..WATER_ALPHA,
			backface_culling = false},
		{name = "nodez_water_flowing.png"..WATER_ALPHA,
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
	liquid_alternative_flowing = "nodez:water_flowing",
	liquid_alternative_source = "nodez:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
	groups = {water = 3, liquid = 3},
})

minetest.register_node("nodez:river_water_source", {
	description = S("River Water Source").."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	waving = 3,
	tiles = { "nodez_river_water.png"..WATER_ALPHA },
	special_tiles = {
		{name = "nodez_river_water.png"..WATER_ALPHA, backface_culling = false},
		{name = "nodez_river_water.png"..WATER_ALPHA, backface_culling = true},
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
})

minetest.register_node("nodez:river_water_flowing", {
	description = S("Flowing River Water").."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"nodez_river_water_flowing.png"..WATER_ALPHA},
	special_tiles = {
		{name = "nodez_river_water_flowing.png"..WATER_ALPHA,
			backface_culling = false},
		{name = "nodez_river_water_flowing.png"..WATER_ALPHA,
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
})
