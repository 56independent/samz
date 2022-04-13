kitz.register_mob("lamb", {
	desc = "Lamb",
	egg_inv_img = "kitz_spawnegg_lamb.png",
	collisionbox = 	{xmin= -0.0625, ymin = -0.5, zmin = -0.125, xmax = 0.125, ymax = -0.125, zmax= 0.1875},
	drops = {
		{name = "petz:mini_lamb_chop", chance = 1, min = 1, max = 1,},
		{name = "petz:bone", chance = 5, min = 1, max = 1,},
	},
	replace_rate = 10,
	replace_offset = 0,
	replace_what = {
		{"group:grass", "air", -1},
		{"default:dirt_with_grass", "default:dirt", -2}
	},
	scale = 2.5,
	textures = {"white"},
})

