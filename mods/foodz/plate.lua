local S = ...

minetest.register_node("foodz:plate", {
	description = S("Plate"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, -0.4375, 0.3125}, -- NodeBox1
			{-0.3125, -0.4375, -0.3125, -0.25, -0.375, 0.3125}, -- NodeBox2
			{0.25, -0.4375, -0.3125, 0.3125, -0.375, 0.3125}, -- NodeBox3
			{-0.3125, -0.5, 0.25, 0.3125, -0.375, 0.3125}, -- NodeBox4
			{-0.25, -0.5, -0.3125, 0.25, -0.375, -0.25}, -- NodeBox5
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	groups = {choppy = 2},
	-- There are 4 variants numbered 0 to 3.
	variant_count = 2,
	-- The lowest 2 bits store the variant number.
	param2_variant = {width = 1, offset = 0},
	--These tiles will be used for variants not otherwise specified,
	-- in this case variant 0.
	tiles = {"nodez_terracota.png", "nodez_terracota.png"},
	-- Tiles for variants 1, 2, and 3 are specified here.
	variant_tiles = {
		{"foodz_vegetable_soup.png", "nodez_terracota.png"},
	},

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.param2 = minetest.set_param2_variant(node.param2, 1, minetest.registered_nodes[node.name])
		minetest.swap_node(pos, node)
	end
})
