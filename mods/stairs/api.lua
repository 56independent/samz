-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description)
	local stairs_name = "stairs:stair_" .. subname
	minetest.register_node("stairs:stair_" .. subname, {
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
	minetest.register_craft({
		output = stairs_name,
		type = "shaped",
		recipe = {
			{recipeitem, "",
			recipeitem}, {recipeitem, "", ""},
			{"", "", ""},
		}
	})
end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description)
	local slab_name = "stairs:slab_" .. subname
	minetest.register_node("stairs:slab_" .. subname, {
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
	minetest.register_craft({
		output = slab_name,
		type = "shaped",
		recipe = {
			{"", "",
			recipeitem}, {recipeitem, "", ""},
			{"", "", ""},
		}
	})
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, def)
	stairs.register_stair(subname, def.recipeitem, def.groups, def.images, def.desc_stair)
	stairs.register_slab(subname, def.recipeitem, def.groups, def.images, def.desc_slab)
end
