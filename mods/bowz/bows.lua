local S = ...

bowz.register_arrow("bowz:e_arrow", {
	damage = 5,
	inventory_arrow = {
		name = "bowz:inv_arrow",
		description = S("Arrow"),
		inventory_image = "bowz_arrow.png",
	},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

minetest.register_craft({
	output = "bowz:inv_arrow 5",
	type = "shaped",
	recipe = {
		{"itemz:string", "nodez:iron_ingot"},
		{"treez:stick", ""},
	},
})

bowz.register_arrow("bowz:mese_arrow", {
	damage = 8,
	inventory_arrow = {
		name = "bowz:inv_mese_arrow",
		description = S("Mese Arrow"),
		inventory_image = "bowz_mese_arrow.png",
	},
	--embed = {
		--texture = "bowz_arrow_stick.png",
		--groups = {"dirt", "wood", "leaf"},
	--},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

minetest.register_craft({
	output = "bowz:inv_mese_arrow 5",
	type = "shaped",
	recipe = {
		{"itemz:string", "nodez:mese_crystal"},
		{"treez:stick", "" }
	},
})

bowz.register_arrow("bowz:fire_arrow", {
	projectile_texture = "bowz_proyectile_arrow",
	damage = 7,
	inventory_arrow = {
		name = "bowz:inv_fire_arrow",
		description = S("Fire Arrow"),
		inventory_image = "bowz_arrow_fire.png",
	},
	drop = "bowz:inv_arrow",
	effects = {
		replace_node = "firez:fire",
		trail_particle = "sparkle.png",
	},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

minetest.register_craft({
	output = "bowz:inv_fire_arrow 2",
	type = "shaped",
	recipe = {
		{"itemz:string", "nodez:iron_ingot"},
		{"treez:stick", "torchz:torch"},
	},
})

bowz.register_arrow("bowz:explosive_arrow", {
	projectile_texture = "bowz_proyectile_arrow",
	damage = 12,
	inventory_arrow = {
		name = "bowz:inv_explosive_arrow",
		description = S("Explosive Arrow"),
		inventory_image = "bowz_arrow_explosive.png",
	},
	drop = "",
	effects = {
		explosion = {
			mod = "boomz",
			damage = 6,
			radius = 3,
		},
		trail_particle = "sparkle.png",
	},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

minetest.register_craft({
	output = "bowz:inv_explosive_arrow",
	type = "shaped",
	recipe = {
		{"itemz:string", "nodez:iron_ingot"},
		{"treez:stick", "boomz:powder_stick"},
	},
})

bowz.register_arrow("bowz:water_arrow", {
	projectile_texture = "bowz_water_arrow",
	damage = 2,
	inventory_arrow = {
		name = "bowz:inv_water_arrow",
		description = S("Water Arrow"),
		inventory_image = "bowz_arrow_water.png",
	},
	drop = "bucketz:bucket",
	effects = {
		trail_particle = "nodez_water.png",
		water = {
			radius = 5,
			flame_node = "firez:fire",
			particles = true,
		},
	},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

minetest.register_craft({
	output = "bowz:inv_water_arrow",
	type = "shaped",
	recipe = {
		{"nodez:water_source", "nodez:iron_ingot"},
		{"treez:stick", "bucketz:bucket"},
	},
})

bowz.register_bow("bowz:bow_wood", {
	description = S("Wooden Far Bow"),
	image = "bowz_bow_wood.png",
	strength = 15,
	uses = 150,
	charge_time = 0.5,
	recipe = {
		{"group:wood", "itemz:string"},
		{"group:wood", "itemz:string"},
	},
	base_texture = "bowz_base_bow_wood.png",
	overlay_empty = "bowz_overlay_empty.png",
	overlay_charged = "bowz_overlay_charged.png",
	arrows = "bowz:e_arrow",
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

bowz.register_bow("bowz:bow_mese", {
	description = S("Mese Far Bow"),
	image = "bowz_bow_mese.png",
	strength = 35,
	uses = 800,
	charge_time = 0.8,
	recipe = {
		{"nodez:mese_crystal", "itemz:string"},
		{"nodez:mese_crystal", "itemz:string"}
	},
	base_texture = "bowz_base_bow_mese.png",
	overlay_empty = "bowz_overlay_empty.png",
	overlay_charged = "bowz_overlay_charged.png",
	arrows = {"bowz:mese_arrow", "bowz:e_arrow"},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	},
})

bowz.register_bow("bowz:bow_flaming", {
	description = S("Flaming Far Bow"),
	image = "bowz_bow_flaming.png",
	strength = 25,
	uses = 1500,
	charge_time = 0.8,
	recipe = {
		{"nodez:copper_ingot", "itemz:string"},
		{"nodez:copper_ingot", "itemz:string"}
	},
	base_texture = "bowz_base_bow_flaming.png",
	overlay_empty = "bowz_overlay_empty.png",
	overlay_charged = "bowz_overlay_flaming_charged.png",
	arrows = {"bowz:explosive_arrow", "bowz:fire_arrow", "bowz:water_arrow", "bowz:e_arrow"},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	}
})

bowz.register_bow("bowz:crossbow", {
	description = S("Crossbow"),
	image = "bowz_crossbow.png",
	strength = 20,
	uses = 1000,
	charge_time = 1.0,
	recipe = {
		{"group:wood", "itemz:string"},
		{"bowz:tripwire", "itemz:string"},
	},
	base_texture = "bowz_base_crossbow.png",
	overlay_empty = "bowz_crossbow_overlay_empty.png",
	overlay_charged = "bowz_crossbow_overlay_charged.png",
	arrows = {"bowz:e_arrow"},
	sounds = {
		max_hear_distance = 10,
		gain = 0.4,
	}
})

minetest.register_craftitem("bowz:tripwire", {
	description = S("Tripwire Hook"),
	inventory_image = "bowz_tripwire.png",
	groups = {weapon=1}
})

minetest.register_craft({
	output = "bowz:tripwire 2",
	type = "shaped",
	recipe = {
		{"", "nodez:iron_ingot"},
		{"treez:stick", "group:wood"},
	},
})
