--
-- Apple Tree
--

local S, modpath = ...

local fruit_grow_time = 1200

-- Apple Fruit

minetest.register_node("treez:apple", {
	description = S("Apple"),
	drawtype = "plantlike",
	tiles = {"treez_apple.png"},
	inventory_image = "treez_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "treez:apple", param2 = 1})
	end,

	on_dig = function(pos, node, digger)
		if digger:is_player() then
			local inv = digger:get_inventory()
			if inv:room_for_item("main", "treez:apple") then
				inv:add_item("main", "treez:apple")
			end
		end
		minetest.remove_node(pos)
		pos.y = pos.y + 1
		local node_above = minetest.get_node_or_nil(pos)
		if node_above and node_above.param2 == 0 and node_above.name == "treez:apple_tree_leaves" then
			--20% of variation on time
			local twenty_percent = fruit_grow_time * 0.2
			local grow_time = math.random(fruit_grow_time - twenty_percent, fruit_grow_time + twenty_percent)
			minetest.get_node_timer(pos):start(grow_time)
		end
	end,
})

-- Apple Tree

local function grow_new_apple_tree(pos)
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-2, y = pos.y, z = pos.z-2}, modpath.."/schematics/apple_tree.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		name = "treez:apple_tree",
		deco_type = "schematic",
		place_on = "nodez:dirt_with_grass",
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.00005,
			spread = {x = 250, y = 250, z = 250},
			seed = 1242,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"forest"},
		y_min = 1,
		y_max = 32,
		schematic = modpath.."/schematics/apple_tree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("treez:apple_tree_sapling", {
	description = S("Apple Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"apple_tree_sapling.png"},
	inventory_image = "apple_tree_sapling.png",
	wield_image = "apple_tree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_cherrytree_tree,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},

	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400, 4800))
	end,

})

minetest.register_node("treez:apple_tree_trunk", {
	description = S("Apple Tree Trunk"),
	tiles = {
		"treez_apple_tree_trunk_top.png",
		"treez_apple_tree_trunk_top.png",
		"treez_apple_tree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

minetest.register_node("treez:apple_tree_wood", {
	description = S("Apple Tree Wood"),
	tiles = {"treez_apple_tree_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
})

minetest.register_node("treez:appletree_leaves", {
	description = S("Apple Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"treez_apple_tree_leaves.png"},
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"treez:apple_tree_sapling"}, rarity = 20},
			{items = {"treez:apple_tree_leaves"}}
		}
	},
})

--
-- Recipes
--

minetest.register_craft({
	output = "treez:apple_tree_wood 4",
	recipe = {{"treez:apple_tree_trunk"}}
})


minetest.register_craft({
	type = "fuel",
	recipe = "treez:apple_tree_trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "treez:apple_tree_wood",
	burntime = 7,
})
