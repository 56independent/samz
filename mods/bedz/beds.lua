local S = ...

bedz.register_bed("simple_bed", {
	description= S("Bed"),
	mesh = "bedz_simple_bed.obj",
	tiles = {
		"bedz_simple_bed.png",
	},
	selectionbox = {
		{-0.5, -0.5, -0.5, 0.5, 0.125, 1.5},
	},
	inventory_image = "bedz_simple_bed_inv.png",
})

minetest.register_craft({
	output = "bedz:simple_bed",
	type = "shaped",
	recipe = {
		{"group:wood",  "",
		 "treez:stick"},{"treez:stick", "", ""},
		{"", "", ""},
	}
})
