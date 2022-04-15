S = ...

--
-- Shovels (dig crumbly)
--

minetest.register_tool("toolz:shovel_steel", {
	description = S("Iron Shovel"),
	inventory_image = "toolz_ironshovel.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			crumbly={times={[1]=1.00, [2]=0.70, [3]=0.60}, uses=90, maxlevel=0}
		},
	},
})




