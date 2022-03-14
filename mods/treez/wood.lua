local S = ...

--Stick
minetest.register_craftitem("treez:stick", {
	description = S("Stick"),
	inventory_image = "treez_stick.png",
	groups = {stick = 1, flammable = 3}
})

minetest.register_craft({
	output = "treez:stick 4",
	type = "shapeless",
	recipe = {
		"group:wood"
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "treez:stick",
	burntime = 5,
})
