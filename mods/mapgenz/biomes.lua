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
	node_top = "nodez:mud",
	depth_top = 1,
	node_filler = "nodez:mud",
	depth_filler = 3,
	node_riverbed = "nodez:mud",
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
