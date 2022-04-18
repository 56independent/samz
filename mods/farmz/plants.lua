farmz.register_plant("wheat", {
	modname = "farmz",
	description = "Wheat",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 2,
	groups = {fleshy = 3, flammable = 2, wheat = 1},
	craft = {
		name = "flour",
		description = "Flour",
		input_amount = 4,
		output_amount = 1,
		groups = {food = 1}
	},
	only_register_sprout = false,
})

