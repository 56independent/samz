local mg_name = minetest.get_mapgen_setting("mg_name")

biomes = {}

if mg_name == "valleys" then
	biomes.peaky_mountain_height = 85
elseif mg_name == "carphatian" then
	biomes.peaky_mountain_height = 65
elseif mg_name == "v7"  then
	biomes.peaky_mountain_height = 45
else
	biomes.peaky_mountain_height = 55
end

--
-- Aliases for map generator outputs
--

-- ESSENTIAL node aliases
-- Basic nodes
minetest.register_alias("mapgen_stone", "nodez:stone")
minetest.register_alias("mapgen_water_source", "nodez:water_source")
minetest.register_alias("mapgen_river_water_source", "nodez:river_water_source")

-- Additional essential aliases for v6
minetest.register_alias("mapgen_lava_source", "nodez:lava_source")
minetest.register_alias("mapgen_dirt", "nodez:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "nodez:dirt_with_grass")
minetest.register_alias("mapgen_sand", "nodez:sand")
minetest.register_alias("mapgen_tree", "nodez:tree")
minetest.register_alias("mapgen_leaves", "nodez:leaves")
minetest.register_alias("mapgen_apple", "nodez:apple")

-- Essential alias for dungeons
minetest.register_alias("mapgen_cobble", "nodez:cobble")

-- Optional aliases for v6 (they all have fallback values in the engine)
if minetest.settings:get_bool("devtest_v6_mapgen_aliases", false) then
	minetest.register_alias("mapgen_gravel", "nodez:gravel")
	minetest.register_alias("mapgen_desert_stone", "nodez:desert_stone")
	minetest.register_alias("mapgen_desert_sand", "nodez:desert_sand")
	minetest.register_alias("mapgen_dirt_with_snow", "nodez:dirt_with_snow")
	minetest.register_alias("mapgen_snowblock", "nodez:snowblock")
	minetest.register_alias("mapgen_snow", "nodez:snow")
	minetest.register_alias("mapgen_ice", "nodez:ice")
	minetest.register_alias("mapgen_junglegrass", "nodez:junglegrass")
	minetest.register_alias("mapgen_jungletree", "nodez:jungletree")
	minetest.register_alias("mapgen_jungleleaves", "nodez:jungleleaves")
	minetest.register_alias("mapgen_pine_tree", "nodez:pine_tree")
	minetest.register_alias("mapgen_pine_needles", "nodez:pine_needles")
end
-- Optional alias for mossycobble (should fall back to cobble)
if minetest.settings:get_bool("devtest_dungeon_mossycobble", false) then
	minetest.register_alias("mapgen_mossycobble", "nodez:mossycobble")
end
-- Optional aliases for dungeon stairs (should fall back to full nodes)
if minetest.settings:get_bool("devtest_dungeon_stairs", false) then
	minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
	if minetest.settings:get_bool("devtest_v6_mapgen_aliases", false) then
		minetest.register_alias("mapgen_stair_desert_stone", "stairs:stair_desert_stone")
	end
end

--
-- Register biomes for biome API
--

if mg_name == "v6" or mg_name == "singlenode" then
	return
end

minetest.clear_registered_biomes()
minetest.clear_registered_decorations()

minetest.register_biome({
	name = "forest",
	node_top = "nodez:dirt_with_grass",
	depth_top = 1,
	node_filler = "nodez:dirt",
	depth_filler = 1,
	node_riverbed = "nodez:sand",
	depth_riverbed = 2,
	node_dungeon = "nodez:cobble",
	node_dungeon_alt = "nodez:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "forest_ocean",
	node_top = "nodez:sand",
	depth_top = 1,
	node_filler = "nodez:sand",
	depth_filler = 3,
	node_riverbed = "nodez:sand",
	depth_riverbed = 2,
	node_cave_liquid = "nodez:water_source",
	node_dungeon = "nodez:cobble",
	node_dungeon_alt = "nodez:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = 0,
	y_min = -255,
	heat_point = 45.5,
	humidity_point = 55.5,
})

minetest.register_biome({
	name = "beach",
	node_top = "nodez:sand",
	depth_top = 1,
	node_filler = "nodez:sand",
	depth_filler = 3,
	node_riverbed = "nodez:sand",
	depth_riverbed = 2,
	node_cave_liquid = "nodez:water_source",
	node_dungeon = "nodez:cobble",
	node_dungeon_alt = "nodez:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = 3,
	y_min = -255,
	heat_point = 55.2,
	humidity_point = 56.2,
})

minetest.register_biome({
	name = "grassland_under",
	node_cave_liquid = {"nodez:water_source", "nodez:lava_source"},
	node_dungeon = "nodez:cobble",
	node_dungeon_alt = "nodez:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -256,
	y_min = -31000,
	heat_point = 43.7,
	humidity_point = 40.7,
})

--Desert Biome

minetest.register_biome({
	name = "desert",
	node_top = "nodez:desert_sand",
	depth_top = 1,
	node_filler = "nodez:sandstone",
	depth_filler = 6,
	node_riverbed = "nodez:desert_sand",
	depth_riverbed = 2,
	node_cave_liquid = "nodez:water_source",
	node_dungeon = "nodez:cobble",
	node_dungeon_alt = "nodez:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = 31000,
	y_min = -4,
	heat_point = 85,
	humidity_point = 15,
})

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

--Clay

minetest.register_decoration({
	decoration = "nodez:clay",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass", "nodez:sand"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "forest_ocean", "beach"},
	noise_params = {
		offset = 0.005,
		scale = 0.008,
		spread = {x = 250, y = 250, z = 250},
		seed = 222,
		octaves = 3,
		persist = 0.66
	},
	y_min = 0,
	y_max = 1,
	spawn_by = "nodez:water_source",
	num_spawn_by = 1,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

minetest.register_decoration({
	decoration = "nodez:clay",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass", "nodez:sand"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "forest_ocean", "beach"},
	noise_params = {
		offset = 0.5,
		scale = 0.8,
		spread = {x = 250, y = 250, z = 250},
		seed = 222,
		octaves = 3,
		persist = 0.66
	},
	y_min = 0,
	y_max = 1,
	spawn_by = "nodez:clay",
	num_spawn_by = 1,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

--Ice

minetest.register_decoration({
	decoration = "nodez:ice",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "beach"},
	noise_params = {
		offset = -0.005,
		scale = 0.008,
		spread = {x = 64, y = 64, z = 64},
		seed = 1342,
		octaves = 3,
		persist = 0.66
	},
	y_min = biomes.peaky_mountain_height,
	y_max = 200,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})


minetest.register_decoration({
	decoration = "nodez:ice",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	spawn_by = "nodez:ice",
	num_spawn_by = 1,
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "beach"},
	noise_params = {
		offset = 2.5,
		scale = 2.5,
		spread = {x = 64, y = 64, z = 64},
		seed = 402,
		octaves = 3,
		persist = 0.66
	},
	y_min = biomes.peaky_mountain_height,
	y_max = 200,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

--Snow

minetest.register_decoration({
	decoration = "nodez:dirt_with_snow",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "beach"},
	noise_params = {
		offset = 0.5,
		scale = 0.8,
		spread = {x = 250, y = 250, z = 250},
		seed = 672,
		octaves = 3,
		persist = 0.66
	},
	y_min = biomes.peaky_mountain_height,
	y_max = 200,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

minetest.register_decoration({
	decoration = "nodez:dirt_with_snow",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "beach"},
	noise_params = {
		offset = 0.5,
		scale = 5.0,
		spread = {x = 250, y = 250, z = 250},
		seed = 91,
		octaves = 3,
		persist = 0.66
	},
	y_min = biomes.peaky_mountain_height,
	y_max = 200,
	spawn_by = "nodez:dirt_with_snow",
	num_spawn_by = 1,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
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


