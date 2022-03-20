--Apple Tree
treez.register_tree("apple_tree", {
	description = "Apple Tree",
	fruit = {
		name = "apple",
		description = "Apple",
		hp = 2,
		hunger = 1.5
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
	}
})

--Cherry Tree
treez.register_tree("cherry_tree", {
	description = "Cherry Tree",
	fruit = {
		name = "cherries",
		description = "Cherries",
		hp = 1.5,
		hunger = 1,
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
	}
})
