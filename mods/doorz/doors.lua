doorz.register_door("apple_tree", {
	description = "Apple Tree",
	tiles = {"doorz_apple_tree.png", backface_culling = true},
	inventory_image = "doorz_apple_tree_inv.png",
	recipe = {
		{"", "treez:apple_tree_wood"},
		{"", "treez:apple_tree_wood"}
	},
	sounds = sound.wood(),
})

doorz.register_door("red_aluminnum", {
	description = "Red Aluminum",
	tiles = {"doorz_red_aluminum.png", backface_culling = true},
	inventory_image = "doorz_red_aluminum_inv.png",
	sounds = sound.metal(),
})

doorz.register_door("green_aluminnum", {
	description = "Green Aluminum",
	tiles = {"doorz_green_aluminum.png", backface_culling = true},
	inventory_image = "doorz_green_aluminum_inv.png",
	sounds = sound.metal(),
})

