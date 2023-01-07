local S = ...

minetest.register_node("nodez:sand", {
	description = S("Sand"),
	tiles ={"nodez_sand.png"},
	groups = {crumbly=3, sand=1, build=1},
	sounds = sound.sand()
})

minetest.register_node("nodez:desert_sand", {
	description = S("Desert Sand"),
	tiles ={"nodez_desert_sand.png"},
	groups = {crumbly=3, sand=1, build=1},
	sounds = sound.sand()
})

minetest.register_node("nodez:sandstone", {
	description = S("Sandstone"),
	tiles ={"nodez_sandstone.png"},
	groups = {crumbly=3, sandstone=1, stone =1, build=1},
	sounds = sound.stone()
})

--Glass

minetest.register_node("nodez:glass", {
	description = S("Glass").."\n"..minetest.colorize("yellow", S("Dyeable")),
	drawtype = "glasslike_framed_optional",
	inventory_image = "nodez_glass_inv.png",
	tiles = {"nodez_glass.png", "nodez_glass_detail.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	--paramtype2 = "glasslikeliquidlevel",
	paramtype2 = "color",
	palette = "palette256.png",
	place_param2 = 1,
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3, glass=1, deco=1, build=1, dyeable = 256},
	oddly_breakable_by_hand = 3,
	sounds = sound.glass()
})

minetest.register_craft({
	type = "cooking",
	output = "nodez:glass",
	recipe = "group:sand",
})
