S = ...

-- Mese Pickaxe: special tool that digs "everything" instantly
minetest.register_tool("toolz:pick_mese", {
	description = S("Mese Pickaxe"),
	inventory_image = "toolz_mesepick.png",
	groups = {pickaxe = 2, tool = 1},
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			crumbly={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			snappy={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			choppy={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
			dig_immediate={times={[1]=0.0, [2]=0.0, [3]=0.0}, maxlevel=255},
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_craft({
	output = "toolz:pick_mese",
	type = "shaped",
	recipe = {
		{"nodez:mese_crystal", "nodez:mese_crystal"},
		{"nodez:mese_crystal", ""}
	}
})

--
-- Pickaxes: Dig cracky
--

minetest.register_tool("toolz:pick_steel", {
	description = S("Iron Pickaxe"),
	inventory_image = "toolz_ironpick.png",
	groups = {pickaxe = 1, tool = 4},
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=90, maxlevel=0}
		},
		damage_groups = {fleshy=2},
	},
})

minetest.register_craft({
	output = "toolz:pick_steel",
	type = "shaped",
	recipe = {
		{"nodez:iron_ingot", "nodez:iron_ingot"},
		{"treez:stick", ""},
	}
})
