local S = ...

--Iron

minetest.register_craftitem("nodez:iron_ingot", {
	description = S("Iron Ingot"),
	inventory_image = "nodez_iron_ingot.png",
	groups = {ore = 1}
})

minetest.register_craft({
	type = "cooking",
	output = "nodez:iron_ingot",
	recipe = "nodez:iron_lump",
	cooktime = 7,
})
