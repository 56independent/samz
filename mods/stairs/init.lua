stairs = {}

-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	})
end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	})
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab)
end

stairs.register_stair_and_slab("stone", "nodez:stone",
		{cracky=3},
		{"default_stone.png"},
		"Stone Stair",
		"Stone Slab")

stairs.register_stair_and_slab("desert_stone", "nodez:desert_stone",
		{cracky=3},
		{"default_desert_stone.png"},
		"Desert Stone Stair",
		"Desert Stone Slab")

stairs.register_stair_and_slab("cobble", "nodez:cobble",
		{cracky=3},
		{"default_cobble.png"},
		"Cobblestone Stair",
		"Cobblestone Slab")
