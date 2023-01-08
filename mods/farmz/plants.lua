local modname = ...

farmz.register_plant("wheat", {
	modname = modname,
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

--Cotton

farmz.register_plant("cotton", {
	modname = modname,
	description = "Cotton",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 3,
	groups_product = {flammable = 2, cotton = 1},
	only_register_sprout = false,
	gather = false,
})

--Pumpkin

farmz.register_plant("pumpkin", {
	modname = modname,
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
		groups = {food = 4, hunger = 4, pumpkin = 1},
	},
	craft_seed = {
		input = "craft",
		input_amount = 1,
		output_amount = 1,
	}
})

--Watermelon
farmz.register_plant("watermelon", {
	modname = modname,
	description = "Watermelon",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	groups_product = {flammable = 2, pumpkin = 1},
	fruit = {
		name = "watermelon",
		amount = 3,
		grow_time = 5,
		description = "Watermelon",
		tiles = {"farmz_watermelon_top.png", "farmz_watermelon_bottom.png", "farmz_watermelon_side.png"},
		groups = {crumbly=1, watermelon=1},
	},
	only_register_sprout = false,
	gather = false,
	craft = {
		name = "watermelon_slice",
		description = "Watermelon Slice",
		input_amount = 1,
		output_amount = 4,
		groups = {food = 4, pumpkin = 1, hunger = 4},
	},
	craft_seed = {
		input = "craft",
		input_amount = 1,
		output_amount = 1,
	}
})

--Tomato

farmz.register_plant("tomato", {
	modname = modname,
	description = "Tomato",
	tall_plant = true,
	hp = 3,
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 6,
	groups_product = {flammable = 2, cotton = 1},
	only_register_sprout = false,
	gather = false,
})
