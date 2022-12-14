S = ...

--
-- Axes (dig choppy)
--


--Stone --also can pick
minetest.register_tool("toolz:axe_stone", {
	description = S("Stone Axe"),
	inventory_image = "toolz_stoneaxe.png",
	groups = {axe = 1, weapon=1, tool = 2},
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[2]=1.00, [3]=0.60}, uses=60, maxlevel=0},
			cracky={times={[1]=8.00, [2]=4, [3]=2}, uses=20, maxlevel=0},
			crumbly={times={[1]=4.00, [2]=2, [3]=1}, uses=30, maxlevel=0}
		},
		damage_groups = {fleshy=3},
	},
})

minetest.register_craft({
	output = "toolz:axe_stone",
	type = "shaped",
	recipe = {
		{"nodez:silex", "nodez:silex"},
		{"", "treez:stick"}
	}
})

--Steel --more versatile
minetest.register_tool("toolz:axe_steel", {
	description = S("Iron Axe"),
	inventory_image = "toolz_ironaxe.png",
	groups = {axe = 2, weapon=3, tool = 2},
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=90, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
})

minetest.register_craft({
	output = "toolz:axe_steel",
	type = "shaped",
	recipe = {
		{"nodez:iron_ingot", "nodez:iron_ingot"},
		{"", "treez:stick"},
	}
})
