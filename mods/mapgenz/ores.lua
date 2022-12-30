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

--Copper
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:copper_ore",
	wherein        = "nodez:stone",
	clust_scarcity = 11 * 11 * 11,
	clust_num_ores = 5,
	clust_size     = 4,
	y_max          = -64,
	y_min          = -512,
})

--Rubi
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

--Mese
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

--Marble
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:marble",
	wherein        = "nodez:stone",
	clust_scarcity = 10 * 10 * 10,
	clust_num_ores = 10,
	clust_size     = 8,
	y_max          = -64,
	y_min          = -256,
})

--Bauxite
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodez:bauxite_ore",
	wherein        = "nodez:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 6,
	clust_size     = 4,
	y_max          = -32,
	y_min          = -288,
})
