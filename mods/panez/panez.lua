panez.register_pane("aluminum_railing", {
	description = "Aluminum Railing",
	textures = {"panez_aluminum_railing.png", "panez_aluminum_railing_rl.png", "panez_aluminum_railing_tb.png"},
	inventory_image = "panez_aluminum_railing.png",
	wield_image = "panez_aluminum_railing.png",
	groups = {cracky=2},
	sounds = sound.metal(),
	recipe = {
		{"nodez:aluminum_ingot", ""},
		{"", "nodez:aluminum_ingot"},
	}
})

panez.register_pane("aluminum_barbed_wire", {
	description = "Aluminum Barbed Wire",
	textures = {"panez_barbed_wire.png", "panez_barbed_wire_rl.png", "panez_barbed_wire_tb.png"},
	inventory_image = "panez_barbed_wire.png",
	wield_image = "panez_barbed_wire.png",
	groups = {cracky=2},
	sounds = sound.metal(),
	recipe = {
		{"nodez:aluminum_ingot", ""},
		{"panez:aluminum_railing", ""},
	}
})
