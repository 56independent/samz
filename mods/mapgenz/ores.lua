-- Register Ores

--Coal
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:coal_ore",
	wherein        = "nodez:stone",
	clust_scarcity = 8 * 8 * 8,
	clust_num_ores = 8,
	clust_size     = 3,
	y_max          = 16,
	y_min          = -512,
})

--Iron
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:iron_ore",
	wherein        = "nodez:stone",
	clust_scarcity = 7 * 7 * 7,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 0,
	y_min          = -512,
})

--Gems
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:ruby_ore",
	wherein        = "nodez:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -384,
	y_min          = -512,
})

--Gems
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:mese_ore",
	wherein        = "nodez:stone",
	clust_scarcity = 21 * 21 * 21,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -384,
	y_min          = -512,
})
