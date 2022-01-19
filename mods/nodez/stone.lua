local S = ...

minetest.register_node("nodez:stone", {
	description = S("Stone"),
	tiles = {"default_stone.png"},
	groups = {cracky=3},
})

minetest.register_node("nodez:cobble", {
	description = S("Cobblestone"),
	tiles ={"default_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})

minetest.register_node("nodez:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles ={"default_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})

minetest.register_node("nodez:gravel", {
	description = S("Gravel"),
	tiles ={"default_gravel.png"},
	groups = {crumbly=2},
})

