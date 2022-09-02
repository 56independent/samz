local S = ...

closetz.register_container("closet", {
	description = S("Closet"),
	inventory_image = "closetz_closet_inv.png",
	mesh = "closet.obj",
	tiles = {
		"closetz_closet.png",
	},
	use_texture_alpha = true,
	selection_box = {
		type = "fixed",
		fixed = { -1/2, -1/2, 0.062500, 1/2, 1.5, 1/2 },
	},
	sounds = sound.wood(),
	sound_open = "default_chest_open",
	sound_close = "default_chest_close",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, deco = 1},
})

minetest.register_craft({
	output = "closetz:closet",
	type = "shaped",
		recipe = {
			{"","group:mirror",
			""},{"group:wood", "", ""},
			{"", "", ""},
	}
})
