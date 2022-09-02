--Reed

minetest.register_node("flowerz:reed", {
	description = S("Reed"),
	drawtype = "plantlike",
	tiles = {"flower_reed.png"},
	inventory_image = "flower_reed.png",
	wield_image = "flower_reed.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1 / 16, -0.5, -1 / 16, 1 / 16, 0.5, 1 / 16},
	},
	groups = {snappy = 3, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})
