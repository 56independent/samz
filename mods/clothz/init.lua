--
-- Clothz
-- License:GPLv3
--

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

--Gray Hoodie

playerz.register_cloth("clothz:gray_hoodie", {
	description = S("Gray Hoodie"),
	texture = "clothz_gray_hoodie.png",
	inventory_image = "clothz_gray_hoodie_inv.png",
	wield_image = "clothz_gray_hoodie_inv.png",
	preview = "clothz_gray_hoodie_preview.png",
	gender = "unisex",
	groups = {cloth = 2},
	attach = "clothz:gray_hoodie_hood",
})

playerz.register_cloth("clothz:gray_hoodie_hood", {
	attached = true,
	texture = "clothz_gray_hoodie_hood.png",
	groups = {cloth = 1, not_in_creative_inventory = 1},
})

--Blue Jeans
playerz.register_cloth("clothz:blue_jeans", {
	description = S("Blue Jeans"),
	texture = "clothz_blue_jeans.png",
	inventory_image = "clothz_blue_jeans_inv.png",
	wield_image = "clothz_blue_jeans_inv.png",
	preview = "clothz_blue_jeans_preview.png",
	gender = "unisex",
	groups = {cloth = 3},
})

--Black Sneakers
playerz.register_cloth("clothz:black_sneakers", {
	description = S("Black Sneakers"),
	texture = "clothz_black_sneakers.png",
	inventory_image = "clothz_black_sneakers_inv.png",
	wield_image = "clothz_black_sneakers_inv.png",
	preview = "clothz_black_sneakers_preview.png",
	gender = "unisex",
	groups = {cloth = 4},
})

--Straw Hat
playerz.register_cloth("clothz:straw_hat", {
	description = S("Straw Hat"),
	texture = "clothz_straw_hat.png",
	inventory_image = "clothz_straw_hat_inv.png",
	wield_image = "clothz_straw_hat_inv.png",
	preview = "clothz_straw_hat_preview.png",
	gender = "unisex",
	groups = {cloth = 5},
})

--Red Cap
playerz.register_cloth("clothz:red_cap", {
	description = S("Red Cap"),
	texture = "clothz_red_cap.png",
	inventory_image = "clothz_red_cap_inv.png",
	wield_image = "clothz_red_cap_inv.png",
	preview = "clothz_red_cap_preview.png",
	gender = "unisex",
	groups = {cloth = 5},
})

--'Lady' Blue Hat
playerz.register_cloth("clothz:lady_hat", {
	description = S("Lady Hat"),
	texture = "clothz_lady_hat.png",
	inventory_image = "clothz_lady_hat_inv.png",
	wield_image = "clothz_lady_hat_inv.png",
	preview = "clothz_lady_hat_preview.png",
	gender = "female",
	groups = {cloth = 5},
})

--Checked Shirt
playerz.register_cloth("clothz:checked_shirt", {
	description = S("Checked Shirt"),
	texture = "clothz_checked_shirt.png",
	inventory_image = "clothz_checked_shirt_inv.png",
	wield_image = "clothz_checked_shirt_inv.png",
	preview = "clothz_checked_shirt_preview.png",
	gender = "male",
	groups = {cloth = 2},
})

--Girly Sweater
playerz.register_cloth("clothz:girly_sweater", {
	description = S("Girly Sweater"),
	texture = "clothz_girly_sweater.png",
	inventory_image = "clothz_girly_sweater_inv.png",
	wield_image = "clothz_girly_sweater_inv.png",
	preview = "clothz_girly_sweater_preview.png",
	gender = "female",
	groups = {cloth = 2},
})

--Schoolgirl Shoes
playerz.register_cloth("clothz:schoolgirl_shoes", {
	description = S("Schoolgirl Shoes"),
	texture = "clothz_schoolgirl_shoes.png",
	inventory_image = "clothz_schoolgirl_shoes_inv.png",
	wield_image = "clothz_schoolgirl_shoes_inv.png",
	preview = "clothz_schoolgirl_shoes_preview.png",
	gender = "female",
	groups = {cloth = 4},
})
