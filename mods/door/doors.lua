door.register_door("apple_tree", {
	description = "Apple Tree",
	tiles = {"door_apple_tree.png", backface_culling = true},
	inventory_image = "door_apple_tree_inv.png",
	recipe = {
		{"",  "treez:apple_tree_wood",
		 ""},{"treez:apple_tree_wood", "", ""},
		{"", "", ""},
	}
})
