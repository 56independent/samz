local S = ...

--Bread

minetest.register_craftitem("farmz:bread", {
	description = S("Bread"),
	inventory_image = "farmz_bread.png",
	groups = {food = 1},
	on_use = function(itemstack, user, pointed_thing)
		eatz.item_eat(itemstack, user, "farmz:bread", 6, 8)
		return itemstack
	end,
})

minetest.register_craft({
	type = "cooking",
	output = "farmz:bread",
	recipe = "farmz:flour",
	cooktime = 3,
})
