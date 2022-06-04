--Cactus

floraz.register_growing_plant("cactus", {
	desc= "Cactus",
	drawtype = "normal",
	tiles = {"floraz_cactus_top.png", "floraz_cactus_top.png",
		"floraz_cactus_side.png"},
	groups = {choppy = 3},
	sounds = sound.wood(),
	extra_soil_group = "sand",
	walkable = true,
})

--Reed

floraz.register_growing_plant("reed", {
	desc= "Reed",
	inventory_image = "floraz_reed.png",
	drawtype = "plantlike",
	tiles = {"floraz_reed.png"},
	groups = {snappy = 3, flammable = 2},
	sounds = sound.wood(),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1 / 16, -0.5, -1 / 16, 1 / 16, 0.5, 1 / 16},
	},
	dig_up = true,
})

minetest.register_decoration({
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
			{name = "floraz:reed", force_place = true}, {name = "floraz:reed", force_place = true}, {name = "floraz:reed"}, {name = "floraz:reed"}
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
	place_on = {"nodez:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 7824,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"forest", "beach"},
	y_max = 0,
	y_min = 0,
	schematic = {
		size = {x = 1, y = 5, z = 1},
		data = {
			{name = "nodez:mud", force_place = true}, {name = "floraz:reed"}, {name = "floraz:reed"}, {name = "floraz:reed"}, {name = "floraz:reed"}
		}
	},
	place_offset_y = 1,
})

