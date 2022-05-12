local S = ...

-- Grasses

minetest.register_node("farmz:grass", {
	description = S("Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"farmz_grass.png"},
	inventory_image = "farmz_grass.png",
	wield_image = "farmz_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1, flammable = 1},
	sounds = sound:leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, -5 / 16, 5 / 16},
	},
	drop = {
		max_items = 1,
		items = {
			{
				rarity = 5,
				items = {"farmz:wheat_seed"},
			},
		}
	}
})

minetest.register_node("farmz:swamp_grass", {
	description = S("Swamp Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"farmz_swamp_grass.png"},
	inventory_image = "farmz_swamp_grass.png",
	wield_image = "farmz_swamp_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1, flammable = 1},
	sounds = sound:leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, -5 / 16, 5 / 16},
	},
	drop = {
		max_items = 1,
		items = {
			{
				rarity = 5,
				items = {"farmz:wheat_seed"},
			},
		}
	}
})
