S = ...

--
-- Shears (dig snappy)
--

minetest.register_tool("toolz:shears_steel", {
	description = S("Iron Shears"),
	inventory_image = "toolz_ironshears.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=90, maxlevel=0},
		},
	},
})
