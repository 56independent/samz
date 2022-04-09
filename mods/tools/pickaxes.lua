S = ...

-- Mese Pickaxe: special tool that digs "everything" instantly
minetest.register_tool("tools:pick_mese", {
	description = S("Mese Pickaxe"),
	inventory_image = "tools_mesepick.png",
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

--
-- Pickaxes: Dig cracky
--

minetest.register_tool("tools:pick_steel", {
	description = S("Iron Pickaxe"),
	inventory_image = "tools_ironpick.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=90, maxlevel=0}
		},
		damage_groups = {fleshy=2},
	},
})
