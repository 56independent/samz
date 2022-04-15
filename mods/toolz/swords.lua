S = ...

--
-- Swords (deal damage)
--

minetest.register_tool("toolz:sword_steel", {
	description = S("Iron Sword"),
	inventory_image = "toolz_ironsword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		damage_groups = {fleshy=6},
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
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		damage_groups = {fiery=6},
	}
})

--
-- Dagger: Low damage, fast punch interval
--
minetest.register_tool("toolz:dagger_steel", {
	description = S("Iron Dagger"),
	inventory_image = "toolz_irondagger.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=0,
		damage_groups = {fleshy=2},
	}
})
