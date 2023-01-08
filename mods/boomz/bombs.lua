local S = ...

--Gunpowder

minetest.register_craftitem("boomz:gunpowder", {
	description = S("Gunpowder"),
	inventory_image = "boomz_gunpowder.png",
	groups = {gunpowder=1, weapon=1}
})

minetest.register_craft({
	type = "shapeless",
	output = "boomz:gunpowder",
	recipe = {
		"nodez:coal_lump", "nodez:gravel",
		"nodez:salt"
	}
})

--Powder Stick

throwz.register_throw("boomz:powder_stick", {
	type = "item",
	description = S("Gunpowder Stick"),
	inventory_image = "boomz_powder_stick_inv.png",
	wield_image = "boomz_powder_stick.png",
	strength = 10,
	throw_damage = 0,
	groups = {powder = 1, throw = 1, weapon = 1},
	boom = {
		delay = 3,
		radius = 3,
		player_damage = 6,
	},
	throw_sounds = {
		max_hear_distance = 10,
		gain = 0.6,
	},
	recipe = {
		{"", ""},
		{"", "boomz:gunpowder"},
	},
})
