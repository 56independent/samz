S, modname = ...

deco.register_table("simple_table", {
	description = S("Simple Table"),
	tiles = {
		"treez_apple_tree_wood.png",
		"treez_apple_tree_wood.png",
		"deco_simple_table_side.png",
		"deco_simple_table_side.png",
		"deco_simple_table_side.png",
		"deco_simple_table_side.png",
	},
	node_box = {
		{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- NodeBox14
		{-0.4375, -0.5, 0.3125, -0.3125, 0.3125, 0.4375}, -- NodeBox15
		{-0.4375, -0.5, -0.4375, -0.3125, 0.3125, -0.3125}, -- NodeBox16
		{0.3125, -0.5, 0.3125, 0.4375, 0.3125, 0.4375}, -- NodeBox17
		{0.4375, -0.5, -0.3125, 0.3125, 0.3125, -0.4375}, -- NodeBox19		}
	},
	selection_box = {
		{-0.4375, -0.5, -0.4375, 0.4375, 0.5, 0.4375},
	},
})
