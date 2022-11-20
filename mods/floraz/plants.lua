--Cactus

floraz.register_growing_plant("cactus", {
	desc= "Cactus",
	drawtype = "normal",
	tiles = {"floraz_cactus_top.png", "floraz_cactus_top.png",
		"floraz_cactus_side.png"},
	groups = {choppy = 3, cactus = 1},
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
	groups = {snappy = 3, flammable = 2, reed = 1},
	sounds = sound.leaves(),
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1 / 16, -0.5, -1 / 16, 1 / 16, 0.5, 1 / 16},
	},
	dig_up = true,
})

