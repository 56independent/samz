local S = ...

--Coal

minetest.register_node("nodez:coal_ore", {
	description = S("Coal Ore"),
	tiles = {"nodez_stone.png^nodez_coal_ore.png"},
	groups = {cracky=3, ore=1},
	drop = "nodez:coal_lump 4",
	sounds = sound.stone(),
})

minetest.register_craftitem("nodez:coal_lump", {
	description = S("Coal Lump"),
	inventory_image = "nodez_coal_lump.png",
	groups = {coal=1, flammable=1, ore=1}
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
	groups = {cracky=2, ore=1, iron=1},
	drop = "nodez:iron_lump 3",
	sounds = sound.stone(),
})

minetest.register_craftitem("nodez:iron_lump", {
	description = S("Iron Lump"),
	groups = {ore=1, iron=1},
	inventory_image = "nodez_iron_lump.png"
})

--Copper

minetest.register_node("nodez:copper_ore", {
	description = S("Copper Ore"),
	tiles = {"nodez_stone.png^nodez_copper_ore.png"},
	groups = {cracky=2, ore=1},
	drop = "nodez:copper_lump 4",
	sounds = sound.stone(),
})

minetest.register_craftitem("nodez:copper_lump", {
	description = S("Copper Lump"),
	groups = {ore=1, copper=1},
	inventory_image = "nodez_copper_lump.png"
})

--Aluminium

minetest.register_node("nodez:bauxite_ore", {
	description = S("Bauxite Ore"),
	tiles = {"nodez_stone.png^nodez_bauxite_ore.png"},
	groups = {cracky=2, aluminum=1, ore=1},
	drop = "nodez:bauxite_lump 10",
	sounds = sound.stone(),
})

minetest.register_craftitem("nodez:bauxite_lump", {
	description = S("Bauxite Lump"),
	inventory_image = "nodez_bauxite_lump.png",
	groups = {ore=1, aluminum=1},
})
