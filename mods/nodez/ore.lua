local S = ...

--Coal

minetest.register_node("nodez:coal_ore", {
	description = S("Coal Ore"),
	tiles = {"nodez_stone.png^nodez_coal_ore.png"},
	groups = {cracky = 3},
	drop = "nodez:coal_lump 4",
	sounds = sound.stone(),
})

minetest.register_craftitem("nodez:coal_lump", {
	description = S("Coal Lump"),
	inventory_image = "nodez_coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_craft({
	type = "fuel",
	recipe = "nodez:coal_lump",
	burntime = 40,
})

--Iron

minetest.register_node("nodez:iron_ore", {
	description = S("Iron Ore"),
	tiles = {"nodez_stone.png^nodez_iron_ore.png"},
	groups = {cracky = 2},
	drop = "nodez:iron_lump 3",
	sounds = sound.stone(),
})

minetest.register_craftitem("nodez:iron_lump", {
	description = S("Iron Lump"),
	inventory_image = "nodez_iron_lump.png"
})

--Mese

