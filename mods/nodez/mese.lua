local S = ...

minetest.register_node("nodez:mese_ore", {
	description = S("Mese Ore"),
	tiles = {"nodez_stone.png^nodez_mese_ore.png"},
	groups = {cracky = 1},
	drop = "nodez:mese_crystal 3",
	sounds = sound:stone(),
})

minetest.register_craftitem("nodez:mese_crystal", {
	description = S("Mese Crystal"),
	inventory_image = "nodez_mese_crystal.png",
})
