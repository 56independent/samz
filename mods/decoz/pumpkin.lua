S = ...


--Carved Pumpkin

minetest.register_node("decoz:carved_pumpkin", {
	description = S("Carved Pumpkin"),
	drawtype = "normal",
	paramtype2 = "facedir",
	walkable = true,
	tiles = {"farmz_pumpkin_top.png", "farmz_pumpkin_bottom.png",
		"farmz_pumpkin_side.png", "farmz_pumpkin_side.png",
		"farmz_pumpkin_side.png", "decoz_carved_pumpkin.png"},
	groups = {deco=1, crumbly=1, pumpkin=1},
	sounds = sound.defaults()
})

--Jack'o'lantern

minetest.register_node("decoz:jack_o_lantern", {
	description = S("Jack-o'-lantern"),
	drawtype = "normal",
	walkable = true,
	paramtype = "light",
	light_source = 6,
	paramtype2 = "facedir",
	tiles = {"farmz_pumpkin_top.png", "farmz_pumpkin_bottom.png",
			"farmz_pumpkin_side.png", "farmz_pumpkin_side.png",
			"farmz_pumpkin_side.png", "decoz_jack_o_lantern.png"
	},
	groups = {deco=1, crumbly=1, pumpkin=1},
	sounds = sound.defaults()
})

minetest.register_craft({
	output = "decoz:jack_o_lantern",
	type = "shaped",
	recipe = {
		{"torchz:torch", ""},
		{"decoz:carved_pumpkin", ""}
	}
})
