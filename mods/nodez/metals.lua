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
