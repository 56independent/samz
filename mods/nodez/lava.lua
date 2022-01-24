local S = ...

local LAVA_VISC = 7

minetest.register_node("nodez:lava_flowing", {
	description = S("Flowing Lava").."\n"..
		"4 damage per second".."\n"..
		"Drowning damage: 1",
	drawtype = "flowingliquid",
	tiles = {"nodez_lava_flowing.png"},
	special_tiles = {
		{name="nodez_lava_flowing.png", backface_culling = false},
		{name="nodez_lava_flowing.png", backface_culling = false},
	},
	paramtype = "light",
	light_source = minetest.LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	damage_per_second = 4,
	liquidtype = "flowing",
	liquid_alternative_flowing = "nodez:lava_flowing",
	liquid_alternative_source = "nodez:lava_source",
	liquid_viscosity = LAVA_VISC,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=1},
})

minetest.register_node("nodez:lava_source", {
	description = S("Lava Source").."\n"..
		"4 damage per second".."\n"..
		"Drowning damage: 1",
	drawtype = "liquid",
	tiles = { "nodez_lava.png" },
	special_tiles = {
		{name = "nodez_lava.png", backface_culling = false},
		{name = "nodez_lava.png", backface_culling = true},
	},
	paramtype = "light",
	light_source = minetest.LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	damage_per_second = 4,
	liquidtype = "source",
	liquid_alternative_flowing = "nodez:lava_flowing",
	liquid_alternative_source = "nodez:lava_source",
	liquid_viscosity = LAVA_VISC,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=1},
})
