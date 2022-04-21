foodz.register_food("cherry_cake", {
	type = "block",
	node_box = {
		{-0.25, -0.5, -0.25, 0.25, -0.125, 0.25},
		{-0.0625, -0.125, -0.0625, 0.0625, 0, 0.0625},
	},
	selection_box = {
		{-0.25, -0.5, -0.25, 0.25, -0.125, 0.25},
	},
	tiles = {
		"foodz_cherry_cake_top.png",
		"foodz_cherry_cake_bottom.png",
		"foodz_cherry_cake_side.png",
		"foodz_cherry_cake_side.png",
		"foodz_cherry_cake_side.png",
		"foodz_cherry_cake_side.png",
	},
    description = "Cherry Cake",
    inventory_image = "foodz_cherry_cake_inv.png",
    hp = 12,
    hunger = 16,
    groups = {cake = 1, oddly_breakable_by_hand = 1},
    recipe = {"treez:cherries", "farmz:flour"},
})
