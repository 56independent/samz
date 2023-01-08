local S = ...

--
-- Swords (deal damage)
--

minetest.register_tool("toolz:sword_steel", {
	description = S("Iron Sword"),
	inventory_image = "toolz_ironsword.png",
	groups = {sword = 1, weapon = 4},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		damage_groups = {fleshy=6},
	}
})

minetest.register_craft({
	output = "toolz:sword_steel",
	recipe = {
		{"", "nodez:iron_ingot"},
		{"nodez:iron_ingot", ""}
	}
})

-- Fire/Ice sword: Deal damage to non-fleshy damage groups
minetest.register_tool("toolz:sword_fire", {
	description = S("Fire Sword"),
	inventory_image = "toolz_firesword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		damage_groups = {icy=6},
	}
})

minetest.register_tool("toolz:sword_ice", {
	description = S("Ice Sword"),
	inventory_image = "toolz_icesword.png",
	groups = {sword = 1, weapon = 2},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		damage_groups = {fiery=6},
	}
})

--
-- Dagger: Low damage, fast punch interval
--

throwz.register_throw("toolz:dagger_steel", {
	type = "tool",
	description = S("Iron Dagger"),
	inventory_image = "toolz_irondagger_inv.png",
	wield_image = "toolz_irondagger.png",
	strength = 10,
	throw_damage = 4,
	throw_uses = 20,
	throw_sounds = {
		max_hear_distance = 10,
		gain = 0.6,
	},
	recipe = {
		{"", ""},
		{"", "nodez:iron_ingot"},
	},
	primary_use = {
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level=0,
			damage_groups = {fleshy=2},
		},
		groups = {dagger = 1, weapon = 2},
		sound = {breaks = "default_tool_breaks"},
	},
})
