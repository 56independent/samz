local mg_name = minetest.get_mapgen_setting("mg_name")

mapgenz = {
	biomes = {}
}

if mg_name == "valleys" then
	mapgenz.biomes.peaky_mountain_height = 85
elseif mg_name == "carphatian" then
	mapgenz.biomes.peaky_mountain_height = 65
elseif mg_name == "v7"  then
	mapgenz.biomes.peaky_mountain_height = 45
else
	mapgenz.biomes.peaky_mountain_height = 55
end

mapgenz.biomes.swamp_height = 7

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
-- Register mapgenz.biomes.for biome API
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

--Swampz

minetest.register_biome({
	name = "swamp",
	node_top = "nodez:silt_with_grass",
	depth_top = 1,
	node_filler = "nodez:silt",
	depth_filler = 3,
	node_riverbed = "nodez:sand",
	depth_riverbed = 2,
	node_water = "nodez:muddy_water_source",
	depth_water_top = 5,
	node_water_top = "nodez:muddy_water_source",
	node_stone = "nodez:limestone",
	y_max = mapgenz.biomes.swamp_height,
	y_min = 1,
	heat_point = 80.1,
	humidity_point = 89.1,
	vertical_blend = 0,
})

minetest.register_biome({
	name = "nodez_shore",
	node_top = "nodez:mud",
	depth_top = 1,
	node_filler = "nodez:mud",
	depth_filler = 3,
	node_riverbed = "nodez:sand",
	depth_riverbed = 2,
	node_water = "nodez:water_source",
	depth_water_top = 5,
	node_water_top = "nodez:water_source",
	y_max = 0,
	y_min = -5,
	heat_point = 79.1,
	humidity_point = 90.1,
	vertical_blend = 0,
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
	y_min = mapgenz.biomes.peaky_mountain_height,
	y_max = 200,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

--Gravel

minetest.register_decoration({
	decoration = "nodez:gravel",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass", "nodez:sand"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "forest_ocean", "beach"},
	noise_params = {
		offset = 0.005,
		scale = 0.008,
		spread = {x = 250, y = 250, z = 250},
		seed = 1630,
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
	decoration = "nodez:gravel",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass", "nodez:sand"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"forest", "forest_ocean", "beach"},
	noise_params = {
		offset = 0.8,
		scale = 0.9,
		spread = {x = 250, y = 250, z = 250},
		seed = 1630,
		octaves = 3,
		persist = 0.66
	},
	y_min = 0,
	y_max = 1,
	spawn_by = "nodez:gravel",
	num_spawn_by = 1,
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
	y_min = mapgenz.biomes.peaky_mountain_height,
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
	y_min = mapgenz.biomes.peaky_mountain_height,
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
	y_min = mapgenz.biomes.peaky_mountain_height,
	y_max = 200,
	spawn_by = "nodez:dirt_with_snow",
	num_spawn_by = 1,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

-- Grasses

minetest.register_decoration({
	name = "farmz:grass",
	decoration = "farmz:grass",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.015,
		scale = 0.045,
		spread = {x = 200, y = 200, z = 200},
		seed = 32559,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"forest"},
	y_max = mapgenz.biomes.peaky_mountain_height,
	y_min = 1,
})

-- Swamp Biome
-- IMPORTANT!
-- THE ORDER OF THE DECORATION MATTERS!
-- DO NOT SORT

--Water Source (4x4)

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"nodez:silt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.05,
		scale = 0.05,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"swamp"},
	height = 2,
	y_min = 0,
	y_max = 1000,
	place_offset_y = -1,
	schematic = {
		size = {x = 4, y = 2, z = 4},
		data = {
			{name = "nodez:silt"}, {name = "nodez:silt"}, {name = "nodez:silt"},{name = "nodez:silt"},
			{name = "nodez:silt_with_grass"}, {name = "nodez:silt_with_grass"}, {name = "nodez:silt_with_grass"},{name = "nodez:silt_with_grass"},
			{name = "nodez:silt"}, {name = "nodez:silt"}, {name = "nodez:silt"},{name = "nodez:silt"},
			{name = "nodez:silt_with_grass"}, {name = "nodez:muddy_water_source"}, {name = "nodez:muddy_water_source"},{name = "nodez:silt_with_grass"},
			{name = "nodez:silt"}, {name = "nodez:silt"}, {name = "nodez:silt"},{name = "nodez:silt"},
			{name = "nodez:silt_with_grass"}, {name = "nodez:muddy_water_source"}, {name = "nodez:muddy_water_source"},{name = "nodez:silt_with_grass"},
			{name = "nodez:silt"}, {name = "nodez:silt"}, {name = "nodez:silt"},{name = "nodez:silt"},
			{name = "nodez:silt_with_grass"}, {name = "nodez:silt_with_grass"}, {name = "nodez:silt_with_grass"},{name = "nodez:silt_with_grass"},
			}
	},
	spawn_by = "nodez:silt_with_grass",
	num_spawn_by = 5,
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

--Water Source (1x1) --this goes after the 4x4 deco of swamp water

minetest.register_decoration({
	deco_type = "simple",
	decoration = "nodez:muddy_water_source",
	place_on = {"nodez:silt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.8,
		scale = 0.8,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"swamp"},
	height = 2,
	y_min = 0,
	y_max = 1000,
	place_offset_y = -2,
	spawn_by = "nodez:muddy_water_source",
	num_spawn_by = 6,
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

--Mud with moss --this goes after water (depends on it)

minetest.register_decoration({
	decoration = "nodez:mud_with_moss",
	deco_type = "simple",
	place_on = "nodez:silt_with_grass",
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"swamp"},
	noise_params = {
		offset = 0.5,
		scale = 0.008,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = 80,
	spawn_by = "nodez:muddy_water_source",
	num_spawn_by = 1,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

	--Mud  --this goes after mud with moss (depends on it)

minetest.register_decoration({
	decoration = "nodez:mud",
	deco_type = "simple",
	place_on = "nodez:silt_with_grass",
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"swamp"},
	noise_params = {
		offset = 0.5,
		scale = 0.008,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = 80,
	spawn_by = "nodez:mud_with_moss",
	num_spawn_by = 1,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

--Swamp Grass --this goes after water (depends on it)
minetest.register_decoration({
	name = "farmz:swamp_grass",
	decoration = "farmz:swamp_grass",
	deco_type = "simple",
	place_on = {"nodez:silt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.015,
		scale = 0.045,
		spread = {x = 200, y = 200, z = 200},
		seed = 467,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"swamp"},
	y_max = mapgenz.biomes.peaky_mountain_height,
	y_min = 1,
})

--Cactus

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"nodez:desert_sand"},
	sidelen = 16,
	noise_params = {
		offset = 0.0005,
		scale = 0.0005,
		spread = {x = 250, y = 250, z = 250},
		seed = 2341,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"desert"},
	height = 2,
	y_min = 0,
	y_max = 1000,
	place_offset_y = 1,
	schematic = {
		size = {x = 1, y = 3, z = 1},
		data = {
			{name = "floraz:cactus"}, {name = "floraz:cactus"}, {name = "floraz:cactus"},
			}
	},
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

