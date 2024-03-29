--Apple Tree
treez.register_tree("apple_tree", {
	description = "Apple Tree",
	fruit = {
		name = "apple",
		description = "Apple",
		hp = 2,
		hunger = 1.5,
		inv_img = true,
		selection_box = {-3/16, -6/16, -3/16, 3/16, 8/16, 3/16}
	},
	deco = {
		biomes = {"forest"},
		place_on = "nodez:dirt_with_grass",
		noise_params = {
			offset = -0.005,
			scale = 0.02,
			spread = {x = 250, y = 250, z = 250},
			seed = 729,
			octaves = 3,
			persist = 0.66
		},
	},
	fence = "normal",
})

--Cherry Tree
treez.register_tree("cherry_tree", {
	description = "Cherry Tree",
	fruit = {
		name = "cherries",
		description = "Cherries",
		hp = 1.5,
		hunger = 1,
		inv_img = true,
		selection_box = {-3/16, -1/16, -3/16, 3/16, 8/16, 3/16}
	},
	deco = {
		biomes = {"forest"},
		place_on = "nodez:dirt_with_grass",
		noise_params = {
			offset = -0.005,
			scale = 0.008,
			spread = {x = 250, y = 250, z = 250},
			seed = 237,
			octaves = 3,
			persist = 0.66
		},
	},
	fence = "picket",
})

--Chestnut Tree
treez.register_tree("chestnut_tree", {
	description = "Chestnut Tree",
	fruit = {
		name = "chestnut_burr",
		description = "Chestnut Burr",
		hp = -2,
		hunger = 0,
		inv_img = true,
		selection_box = {-3/16, -3/16, -3/16, 3/16, 8/16, 3/16},
		craft = {
			name= "chestnut",
			description = "Chestnut",
			hp = 2,
			hunger = 3,
			output_no = 3,
		}
	},
	deco = {
		biomes = {"forest"},
		place_on = "nodez:dirt_with_grass",
		noise_params = {
			offset = -0.005,
			scale = 0.008,
			spread = {x = 250, y = 250, z = 250},
			seed = 6702,
			octaves = 3,
			persist = 0.66
		},
	},
	fence = "normal",
})

--Birch
treez.register_tree("birch", {
	description = "Birch",
	deco = {
		biomes = {"forest"},
		place_on = "nodez:dirt_with_grass",
		noise_params = {
			offset = -0.005,
			scale = 0.008,
			spread = {x = 250, y = 250, z = 250},
			seed = 3828,
			octaves = 3,
			persist = 0.66
		},
	},
	fence = "picket",
})

--Willow
treez.register_tree("willow", {
	description = "Willow",
	fence = "normal",
	deco = {
		biomes = {"swamp"},
		place_on = "nodez:silt_with_grass",
		noise_params = {
			offset = 0.01,
			scale = 0.01,
			spread = {x = 250, y = 250, z = 250},
			seed = 3828,
			octaves = 3,
			persist = 0.66
		},
		y_max = mapgenz.biomes.swamp_height,
		place_offset_y = 0,
	},
})

--Spruce
treez.register_tree("fir", {
	description = "Fir",
	fence = "picket",
	deco = {
		biomes = {"boreal"},
		place_on = "nodez:dark_dirt_with_grass",
		noise_params = {
			offset = 0.005,
			scale = 0.005,
			spread = {x = 250, y = 250, z = 250},
			seed = 1236,
			octaves = 3,
			persist = 0.66
		},
		place_offset_y = 1,
	},
})

--Oak
treez.register_tree("oak", {
	description = "Oak",
	fence = "normal",
	deco = {
		biomes = {"boreal"},
		place_on = "nodez:dark_dirt_with_grass",
		noise_params = {
			offset = 0.005,
			scale = 0.005,
			spread = {x = 250, y = 250, z = 250},
			seed = 621,
			octaves = 3,
			persist = 0.66
		},
		place_offset_y = 1,
	},
	fruit = {
		name = "acorn",
		description = "Acorn",
		hp = 1,
		hunger = 1,
		inv_img = true,
		selection_box = {-3/16, -3/16, -3/16, 3/16, 8/16, 3/16},
	},
})
