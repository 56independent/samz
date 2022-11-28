local S = ...

--Iron

minetest.register_craftitem("nodez:iron_ingot", {
	description = S("Iron Ingot"),
	inventory_image = "nodez_iron_ingot.png",
	groups = {ore = 1, iron=1}
})

minetest.register_craft({
	type = "cooking",
	output = "nodez:iron_ingot",
	recipe = "nodez:iron_lump",
	cooktime = 7,
})

--Beam
minetest.register_node("nodez:iron_beam", {
	description = S("Iron Beam"),
	tiles = {"nodez_beam_top.png", "nodez_beam_top.png", "nodez_beam_side.png"},
	groups = {cracky = 3, iron = 1, build = 1},
	sounds = sound.metal(),
})

minetest.register_craft({
	type= "shaped",
	output = "nodez:iron_beam",
	recipe = {
		{"",  "nodez:iron_ingot",
		 ""},{"nodez:iron_ingot", "", ""},
		{"", "", ""},
	}
})

--Copper

minetest.register_craftitem("nodez:copper_ingot", {
	description = S("Copper Ingot"),
	inventory_image = "nodez_copper_ingot.png",
	groups = {ore = 1, copper=1}
})

minetest.register_craft({
	type = "cooking",
	output = "nodez:copper_ingot",
	recipe = "nodez:copper_lump",
	cooktime = 8,
})
