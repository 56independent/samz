farmz.register_plant("wheat", {
	modname = "farmz",
	description = "Wheat",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 2,
	groups_product = {flammable = 2, wheat = 1},
	craft = {
		name = "flour",
		description = "Flour",
		input_amount = 4,
		output_amount = 1,
		groups = {food = 1}
	},
	only_register_sprout = false,
	gather = false,
})

farmz.register_plant("cotton", {
	modname = "farmz",
	description = "Cotton",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 3,
	groups_product = {flammable = 2, cotton = 1},
	only_register_sprout = false,
	gather = false,
})

farmz.register_plant("pumpkin", {
	modname = "farmz",
	description = "Pumpkin",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	groups_product = {flammable = 2, pumpkin = 1},
	fruit = {
		name = "pumpkin",
		amount = 3,
		grow_time = 5,
		description = "Pumpkin",
		tiles = {"farmz_pumpkin_top.png", "farmz_pumpkin_bottom.png", "farmz_pumpkin_side.png"},
		groups = {crumbly=1, pumpkin=1},
		shears = "decoz:carved_pumpkin",
	},
	only_register_sprout = false,
	gather = false,
	craft = {
		name = "pumpkin_slice",
		description = "Pumpkin Slice",
		input_amount = 1,
		output_amount = 4,
		groups = {food = 1, pumpkin = 1}
	},
	craft_seed = {
		input = "craft",
		input_amount = 1,
		output_amount = 1,
	}
})
