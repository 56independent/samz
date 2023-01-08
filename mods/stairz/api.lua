local S, modname = ...

function stairz.register_stair(subname, recipeitem, groups, images, description)

	local stairs_name = modname..":stair_" .. subname

	groups.stair = 1
	groups.build = 1

	minetest.register_node(stairs_name, {

		description = S(description),
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
		output = stairs_name.." 6",
		type = "shaped",
		recipe = {
			{recipeitem, ""},
			{recipeitem, recipeitem},
		}
	})
end

-- Node will be called stairs:slab_<subname>
function stairz.register_slab(subname, recipeitem, groups, images, description)

	local slab_name = modname..":slab_" .. subname

	groups.slab = 1
	groups.build = 1

	minetest.register_node(slab_name, {
		description = S(description),
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
		output = slab_name.." 4",
		type = "shaped",
		recipe = {
			{"", ""},
			{recipeitem, recipeitem},
		}
	})
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairz.register_stair_and_slab(subname, def)
	stairz.register_stair(subname, def.recipeitem, def.groups, def.images, def.desc_stair)
	stairz.register_slab(subname, def.recipeitem, def.groups, def.images, def.desc_slab)
end
