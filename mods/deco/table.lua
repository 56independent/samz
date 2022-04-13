S, modname = ...

minetest.register_node(modname..":".."simple_table", {
	description = S("Simple Table"),
	tiles = {
		"treez_apple_tree_wood.png",
		"treez_apple_tree_wood.png",
		"treez_apple_tree_wood.png",
		"treez_apple_tree_wood.png",
		"treez_apple_tree_wood.png",
		"treez_apple_tree_wood.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox14
			{-0.4375, -0.5, 0.3125, -0.3125, 0.3125, 0.4375}, -- NodeBox15
			{-0.4375, -0.5, -0.4375, -0.3125, 0.3125, -0.3125}, -- NodeBox16
			{0.3125, -0.5, 0.3125, 0.4375, 0.3125, 0.4375}, -- NodeBox17
			{0.4375, -0.5, -0.3125, 0.3125, 0.3125, -0.4375}, -- NodeBox19
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
		},
	},
	sounds = sound.wood(),
	is_ground_content = false,
	stack_max = 1,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, chair = 1},
})
