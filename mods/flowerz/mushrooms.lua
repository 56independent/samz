--Mushrooms

flowerz.mushrooms_list = {
	{
		name = "amanita",
		def = {
			desc = "Amanita",
			hp = -10,
			hunger = 0,
			box = {-2/16, -8/16, -2/16, 2/16, 2/16, 2/16},
			groups = {color_red = 1, flammable = 1},
			inv_img = false,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 345,
				noise_params = {
					scale = 0.0001,
					offset = 0.0001,
				},
				biomes = {"forest"},
				height = {y_max = 65, y_min = 1}
			}
		}
	},
	{
		name = "champignon",
		def = {
			desc = "Champignon",
			hp = 5,
			hunger = 4,
			box = {-2/16, -8/16, -2/16, 2/16, 2/16, 2/16},
			groups = {color_white = 1, flammable = 1},
			inv_img = true,
			deco = {
				type = "simple",
				place_on = "nodez:dirt_with_grass",
				seed = 238,
				noise_params = {
					scale = 0.0001,
					offset = 0.0001,
				},
				biomes = {"forest"},
				height = {y_max = 65, y_min = 1}
			}
		}
	},
}

for _, item in pairs(flowerz.mushrooms_list) do
	flowerz.register_mushroom(item.name, item.def)
end
