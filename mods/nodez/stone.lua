  local S = ...

minetest.register_node("nodez:stone", {
	description = S("Stone"),
	tiles = {"nodez_stone.png"},
	groups = {cracky=3, stone=1},
	sounds = sound.stone(),
})

minetest.register_node("nodez:cobble", {
	description = S("Cobblestone"),
	tiles ={"nodez_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = sound.stone(),
})

minetest.register_node("nodez:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles ={"nodez_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = sound.stone(),
})

minetest.register_node("nodez:gravel", {
	description = S("Gravel"),
	tiles ={"nodez_gravel.png"},
	groups = {crumbly=2},
	sounds = sound.gravel(),
})

