--Bread

foodz.register_food("bread", {
	type = "craft",
	description = "Bread",
	inventory_image = "foodz_bread.png",
	hp = 6,
	hunger = 8,
	groups = {bread = 1},
	recipe = {
		type = "cooking",
		items = "farmz:flour",
		cooktime = 3
	}
})
