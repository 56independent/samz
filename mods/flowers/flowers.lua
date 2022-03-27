local S 	= ...

flowers.list = {
	{
		name = "rose_bush",
		def = {
			desc = S("Rose Bush"),
			box = {-2/16, -0.5, -2/16, 2/16, 5/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Rose"),
			box = {-2/16, -0.5, -2/16, 2/16, 4/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Daisy"),
			box = {-2/16, -0.5, -2/16, 2/16, 5/16, 2/16},
			groups = {color_white = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Tulip"),
			box = {-2/16, -0.5, -2/16, 2/16, 2/16, 2/16},
			groups = {color_yellow = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Pansy"),
			box = {-2/16, -0.5, -2/16, 2/16, 2/16, 2/16},
			groups = {color_pink = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Gerbera Daisy"),
			box = {-4/16, -8/16, -4/16, 4/16, -3/16, 4/16},
			groups = {color_orange = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Lavender"),
			box = {-4/16, -8/16, -4/16, 4/16, -3/16, 4/16},
			groups = {color_violet = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Dandellion"),
			box = {-4/16, -8/16, -4/16, 4/16, -3/16, 4/16},
			groups = {color_yellow = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Dahlia"),
			box = {-2/16, -8/16, -2/16, 2/16, 3/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
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
			desc = S("Zinnia"),
			box = {-4/16, -8/16, -4/16, 4/16, -2/16, 4/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				place_on = "nodez:dirt_with_grass",
				seed = 993,
				biomes = {"forest"},
				height = {y_max = 128, y_min = 1}
			}
		}
	}
}

for _, item in pairs(flowers.list) do
	flowers.register_flower(item.name, item.def)
end

