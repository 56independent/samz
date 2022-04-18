local S = ...

minetest.register_node("nodez:stone", {
	description = S("Stone"),
	tiles = {"nodez_stone.png"},
	groups = {cracky=3, stone=1, build=1},
	sounds = sound.stone(),
})

minetest.register_node("nodez:cobble", {
	description = S("Cobblestone"),
	tiles ={"nodez_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1,build=1},
	sounds = sound.stone(),
})

minetest.register_node("nodez:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles ={"nodez_cobble.png^(nodez_moss.png^[makealpha:50,50,50)"},
	is_ground_content = false,
	groups = {cracky=3, stone=1, build=1},
	sounds = sound.stone(),
})

minetest.register_node("nodez:gravel", {
	description = S("Gravel"),
	tiles ={"nodez_gravel.png"},
	groups = {crumbly=2, build=1},
	sounds = sound.gravel(),
	drop = {
		max_items = 1,
        items = {
			{
				rarity = 10,
				items = {"nodez:silex"},
			},
			{
				items = {"nodez:gravel"},
			},
		}
	}
})

--Silex

minetest.register_craftitem("nodez:silex", {
	description = S("Silex"),
	groups = {silex=1, ore=1},
	inventory_image = "nodez_silex.png"
})
