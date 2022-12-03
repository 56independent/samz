flowerz.flowers_list = {
	{
		name = "calla",
		def = {
			desc = "Calla",
			box = {-4/16, -8/16, -4/16, 4/16, -2/16, 4/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 560,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "rose_bush",
		def = {
			desc = "Rose Bush",
			box = {-2/16, -0.5, -2/16, 2/16, 5/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 345,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1},
				noise_params = {
					scale = 0.02,
				}
			}
		}
	},
	{
		name = "rose",
		def = {
			desc = "Rose",
			box = {-2/16, -0.5, -2/16, 2/16, 4/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 345,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1},
				noise_params = {
					scale = 0.03,
				}
			}
		}
	},
	{
		name = "daisy",
		def = {
			desc = "Daisy",
			box = {-2/16, -0.5, -2/16, 2/16, 5/16, 2/16},
			groups = {color_white = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 1528,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "tulip",
		def = {
			desc = "Tulip",
			box = {-2/16, -0.5, -2/16, 2/16, 2/16, 2/16},
			groups = {color_yellow = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 7898,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "pansy",
		def = {
			desc = "Pansy",
			box = {-2/16, -0.5, -2/16, 2/16, 2/16, 2/16},
			groups = {color_pink = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 734,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "gerbera",
		def = {
			desc = "Gerbera Daisy",
			box = {-4/16, -8/16, -4/16, 4/16, -3/16, 4/16},
			groups = {color_orange = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 5770,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "lavender",
		def = {
			desc = "Lavender",
			box = {-4/16, -8/16, -4/16, 4/16, -3/16, 4/16},
			groups = {color_violet = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 230,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "dandellion",
		def = {
			desc = "Dandellion",
			box = {-4/16, -8/16, -4/16, 4/16, -3/16, 4/16},
			groups = {color_yellow = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 3946,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "dahlia",
		def = {
			desc = "Dahlia",
			box = {-2/16, -8/16, -2/16, 2/16, -0/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 356,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1},
				noise_params = {
					scale = 0.02,
				}
			}
		}
	},
	{
		name = "zinnia",
		def = {
			desc = "Zinnia",
			box = {-4/16, -8/16, -4/16, 4/16, -2/16, 4/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 993,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	},
	{
		name = "bindweed",
		def = {
			desc = "Bindweed",
			box = {-4/16, -8/16, -4/16, 4/16, -2/16, 4/16},
			groups = {color_pink = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 9723,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	}
}

for _, item in pairs(flowerz.flowers_list) do
	flowerz.register_flower(item.name, item.def)
end

--Sunflower

flowerz.register_tall_flower("sunflower", {
	desc = "Sunflower",
	box = {-0.25, -0.5, -0.25, 0.1875, 0.375, 0.1875},
	groups = {color_yellow = 1, flammable = 1},
	inv_img = false,
	deco = {
		type = "schematic",
		place_on = "nodez:dirt_with_grass",
		seed = 521,
		noise_params = {
			scale = 0.03,
		},
		biomes = {"forest"},
		height = {y_max = 128, y_min = 1},
		flags = "place_center_x, place_center_z, force_placement",
		place_offset_y = 1
	}
})

farmz.register_plant("sunflower", {
	modname = "flowerz",
	description = "Sunflower",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 1,
	groups = {flammable = 2, sunflower = 1},
	only_register_sprout = true,
	craft_seed = {
		input_amount = 1,
		output_amount = 4,
	},
})
