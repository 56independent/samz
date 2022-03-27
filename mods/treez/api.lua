local S, modpath, mg_name = ...

local variability = 0.2 --20%
local fruit_grow_time = 1200 --1200 by default
local tree_grow_time = 5 --3600 by default

function treez.register_tree(name, def)
	--Fruit
	if def.fruit then
		local fruit_name = "treez:"..def.fruit.name
		local inventory_image
		if def.fruit.inv_img then
			inventory_image = "treez_"..def.fruit.name.."_inv.png"
		else
			inventory_image = "treez_"..def.fruit.name..".png"
		end

		minetest.register_node(fruit_name, {
			description = S(def.fruit.description),
			drawtype = "plantlike",
			tiles = {"treez_"..def.fruit.name..".png"},
			inventory_image = inventory_image,
			paramtype = "light",
			sunlight_propagates = true,
			walkable = false,
			is_ground_content = false,
			selection_box = {
				type = "fixed",
				fixed = def.fruit.selection_box
			},
			groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
				leafdecay = 3, leafdecay_drop = 1},
			sounds = sound.leaves(),

			on_use = function(itemstack, user, pointed_thing)
				eat.item_eat(itemstack, user, fruit_name, def.fruit.hp, def.fruit.hunger)
				return itemstack
			end,

			after_place_node = function(pos, placer, itemstack)
				minetest.set_node(pos, {name = "treez:"..def.fruit.name, param2 = 1})
			end,

			on_dig = function(pos, node, digger)
				if digger:is_player() then
					local inv = digger:get_inventory()
					if inv:room_for_item("main", "treez:"..def.fruit.name) then
						inv:add_item("main", "treez:"..def.fruit.name)
					end
				end
				minetest.remove_node(pos)
				pos.y = pos.y + 1
				local node_above = minetest.get_node_or_nil(pos)
				if node_above and node_above.param2 == 0 and node_above.name == "treez:"..name.."_leaves" then
					--20% of variation on time
					local grow_time = math.random(fruit_grow_time - (fruit_grow_time * variability),
						fruit_grow_time + (fruit_grow_time * variability))
					minetest.get_node_timer(pos):start(grow_time)
				end
			end,
		})

		if def.fruit.craft then
			local craft_fruit_name = "treez:"..def.fruit.craft.name

			minetest.register_craftitem(craft_fruit_name, {
				description = S(def.fruit.craft.description),
				inventory_image = "treez_"..def.fruit.craft.name..".png",
				groups = {fleshy = 3, flammable = 2, food = 1},
				on_use = function(itemstack, user, pointed_thing)
					eat.item_eat(itemstack, user, craft_fruit_name, def.fruit.craft.hp, def.fruit.craft.hunger)
					return itemstack
				end,
			})

			minetest.register_craft({
				output = craft_fruit_name,
				type = "shapeless",
				recipe = {fruit_name},
			})
		end
	end

	--Sapling
	minetest.register_node("treez:"..name.."_sapling", {
		description = S("@1 Sapling", S(def.description)),
		drawtype = "plantlike",
		tiles = {"treez_"..name.."_sapling.png"},
		inventory_image = "treez_"..name.."_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		sounds = sound.leaves(),

		on_timer = function(pos)
			minetest.remove_node(pos)
			minetest.place_schematic({x = pos.x-2, y = pos.y, z = pos.z-2}, modpath.."/schematics/"..name..".mts", "0",
				nil, false)
		end,

		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
		},

		groups = {snappy = 2, dig_immediate = 3, flammable = 2,
			attached_node = 1, sapling = 1},

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(tree_grow_time - (tree_grow_time * variability),
					tree_grow_time + (tree_grow_time * variability)))
		end,
	})

	--Trunk
	minetest.register_node("treez:"..name.."_trunk", {
		description = S("@1 Trunk", S(def.description)),
		tiles = {
			"treez_"..name.."_trunk_top.png",
			"treez_"..name.."_trunk_top.png",
			"treez_"..name.."_trunk.png"
		},
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		paramtype2 = "facedir",
		is_ground_content = false,
		sounds = sound.wood(),
		on_place = minetest.rotate_node,
	})

	--Wood
	minetest.register_node("treez:"..name.."_wood", {
		description = S("@1 Wood", S(def.description)),
		tiles = {"treez_"..name.."_wood.png"},
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
		sounds = sound.wood(),
	})

	--Leaves
	minetest.register_node("treez:"..name.."_leaves", {
		description =S("@1 Leaves", S(def.description)),
		drawtype = "allfaces_optional",
		tiles = {"treez_"..name.."_leaves.png"},
		paramtype = "light",
		walkable = true,
		waving = 1,
		groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
		drop = {
			max_items = 1,
			items = {
				{items = {"treez:"..name.."_sapling"}, rarity = 20},
				{items = {"treez:"..name.."_leaves"}}
			}
		},
		sounds = sound.leaves(),
	})

	--
	-- Recipes
	--

	minetest.register_craft({
		output = "treez:"..name.."_wood 4",
		recipe = {{"treez:"..name.."_trunk"}}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "treez:"..name.."_trunk",
		burntime = 30,
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "treez:"..name.."_wood",
		burntime = 7,
	})

	--Decoration
	if mg_name ~= "v6" and mg_name ~= "singlenode" then
		minetest.register_decoration({
			name = "treez:"..name,
			deco_type = "schematic",
			place_on = def.deco.place_on,
			sidelen = 16,
			noise_params = def.deco.noise_params,
			biomes = def.deco.biomes,
			y_min = 1,
			y_max = mapgen.biomes.peaky_mountain_height,
			place_offset_y = 1,
			schematic = modpath.."/schematics/"..name..".mts",
			flags = "place_center_x, place_center_z, force_placement",
			rotation = "random",
		})
	end
end
