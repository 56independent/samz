foodz.register_food("sunflower_oil", {
	type = "craft",
	description = "Sunflower Oil",
	inventory_image = "foodz_sunflower_oil.png",
	hp = 1,
	hunger = 1,
	groups = {oil = 1},
	recipe = {
		type = "shapeless",
		items = {"flowerz:sunflower_seed", "flowerz:sunflower_seed", "flowerz:sunflower_seed", "itemz:empty_bottle"}
	}
})
