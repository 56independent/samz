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
	decoration = "nodez:snow_block",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.05,
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
	fill_ratio = 0.05,
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

-- Grasses

minetest.register_decoration({
	name = "farmz:grass",
	decoration = "farmz:grass",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass", "nodez:dark_dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.015,
		scale = 0.045,
		spread = {x = 200, y = 200, z = 200},
		seed = 32559,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"forest", "boreal"},
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
	y_min = 1,
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

--Snow Biome

minetest.register_decoration({
	decoration = "nodez:snow_block",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 2.5,
	biomes = {"forest", "beach"},
	noise_params = {
		offset = -0.5,
		scale = 0.07,
		spread = {x = 250, y = 250, z = 250},
		seed = 672,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = mapgenz.biomes.peaky_mountain_height,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

minetest.register_decoration({
	decoration = "nodez:dirt_with_snow",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 2.5,
	biomes = {"forest", "beach"},
	noise_params = {
		offset = -0.5,
		scale = 0.07,
		spread = {x = 250, y = 250, z = 250},
		seed = 672,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = mapgenz.biomes.peaky_mountain_height,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

--Reed

minetest.register_decoration({
	name = "floraz:reed_in_swamp",
	deco_type = "schematic",
	place_on = {"nodez:silt_with_grass", "nodez:mud_with_moss", "nodez:mud"},
	sidelen = 16,
	noise_params = {
		offset = 0.05,
		scale = 0.005,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"swamp"},
	height = 2,
	y_min = 0,
	y_max = 1000,
	place_offset_y = 1,
	schematic = {
		size = {x = 1, y = 4, z = 1},
		data = {
			{name = "floraz:reed", force_placement = true}, {name = "floraz:reed", force_placement = true},
				{name = "floraz:reed"}, {name = "floraz:reed"}
		}
	},
	spawn_by = "nodez:muddy_water_source",
	num_spawn_by = 1,
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

minetest.register_decoration({
	name = "floraz:reed_in_coast",
	deco_type = "schematic",
	place_on = {"nodez:sand", "nodez:mud"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.3,
		spread = {x = 200, y = 200, z = 200},
		seed = 783224,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"forest_shore", "beach", "swamp_shore"},
	y_max = 0,
	y_min = 0,
	schematic = {
		size = {x = 1, y = 5, z = 1},
		data = {
			{name = "nodez:mud", force_place = true}, {name = "floraz:reed"}, {name = "floraz:reed"},
				{name = "floraz:reed"}, {name = "floraz:reed"}
		}
	},
	place_offset_y = 1,
})

--Boreal

minetest.register_decoration({
	decoration = "nodez:snow_block",
	deco_type = "simple",
	place_on = {"nodez:dark_dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 2.5,
	biomes = {"boreal"},
	noise_params = {
		offset = -0.1,
		scale = 0.8,
		spread = {x = 250, y = 250, z = 250},
		seed = 1340,
		octaves = 3,
		persist = 0.66
	},
	y_min = 1,
	y_max = mapgenz.biomes.peaky_mountain_height,
	place_offset_y = -1,
	flags = "place_center_x, place_center_z, force_placement",
})

minetest.register_decoration({
	decoration = "nodez:floe",
	deco_type = "simple",
	place_on = {"nodez:water_source"},
	sidelen = 16,
	fill_ratio = 2.5,
	biomes = {"boreal_shore"},
	noise_params = {
		offset = 0.5,
		scale = 0.8,
		spread = {x = 250, y = 250, z = 250},
		seed = 451,
		octaves = 3,
		persist = 0.66
	},
	y_min = -5,
	y_max = 1,
	flags = "place_center_x, place_center_z, force_placement",
})

--Pumpkin
minetest.register_decoration({
	decoration = "farmz:pumpkin",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.00005,
		scale = 0.00005,
		spread = {x = 250, y = 250, z = 250},
		seed = 9974,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"forest"},
	y_min = 1,
	y_max = 1000,
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

--Watermelon
minetest.register_decoration({
	decoration = "farmz:watermelon",
	deco_type = "simple",
	place_on = {"nodez:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.00005,
		scale = 0.00005,
		spread = {x = 250, y = 250, z = 250},
		seed = 9974,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"forest"},
	y_min = 1,
	y_max = 1000,
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

--Fern
minetest.register_decoration({
	decoration = "floraz:fern",
	deco_type = "simple",
	place_on = {"nodez:dark_dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.005,
		scale = 0.005,
		spread = {x = 250, y = 250, z = 250},
		seed = 963,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"boreal"},
	y_min = 1,
	y_max = 1000,
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})
