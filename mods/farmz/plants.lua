local S = ...

farmz.register_plant("wheat", {
	description = "Wheat",
	box = {-4/16, -0.5, -4/16, 4/16, 4/16, 4/16},
	grow_time = 5,
	drop_number = 2,
	craft = {
		name = "flour",
		description = "Flour",
		input_amount = 4,
		ouput_amount = 1,
	}
})
