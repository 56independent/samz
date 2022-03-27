S = ...

--
-- Axes (dig choppy)
--

minetest.register_tool("tools:axe_stone", {
	description = S("Stone Axe"),
	inventory_image = "tools_stoneaxe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[2]=1.00, [3]=0.60}, uses=60, maxlevel=0},
		},
	},
})

minetest.register_tool("tools:axe_steel", {
	description = S("Iron Axe"),
	inventory_image = "tools_ironaxe.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=90, maxlevel=0},
		},
	},
})
