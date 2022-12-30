--Pumpkin Cake
foodz.register_food("watermelon_lolly", {
    description = "Watermelon Ice Lolly",
    inventory_image = "foodz_watermelon_ice_lolly_inv.png",
	type = "craft",
    hp = 2,
    hunger = 4,
    groups = {watermelon = 1},
	recipe = {
		type = "shaped",
		output_amount = 2,
		items = {
			{"farmz:watermelon_slice", "nodez:snowball"},
			{"treez:stick", ""}
		}
	}
})
