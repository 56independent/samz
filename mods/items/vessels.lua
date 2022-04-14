S, modname = ...

function items.register_vessel(name, def)
	local vessel_name = modname..":"..name
	minetest.register_node(vessel_name, {
		description = S(def.description),
		drawtype = "plantlike",
		tiles = def.tiles,
		paramtype = "light",
		paramtype2 = "glasslikeliquidlevel",
		param2 = 50,
		sunlight_propagates = true,
		use_texture_alpha = "blend",
		inventory_image = def.inventory_image,
		wield_image = def.wield_image or def.inventory_image or "",
		is_ground_content = false,
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = def.selection_box
		},
		stack_max = 10,
		groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
		drop = def.drop,
		sounds = sound.glass(),

		on_use = function(itemstack, user, pointed_thing)
			if def.replace_item then
				local pos = pointed_thing.above
				if helper.node_is_water(pos) then
					local inv = user:get_inventory()
					if inv:room_for_item("main", def.replace_item) then
						itemstack:take_item(1)
						inv:add_item("main", def.replace_item)
					end
				end
				return itemstack
			end
		end,

		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			if not clicker:is_player() then
				return
			end
			local inv = clicker:get_inventory()
			if inv:room_for_item("main", vessel_name) then
				if itemstack:get_name() == vessel_name or itemstack:get_name() == "" then
					itemstack:add_item(vessel_name)
				else
					inv:add_item("main", vessel_name)
				end
				minetest.remove_node(pos)
			end
			return itemstack
		end
	})

	if def.craft then
		minetest.register_craft({
			output = def.craft.output or vessel_name,
			type = def.craft.type or "shapeless",
			recipe = def.craft.recipe,
		})
	end
end

--Empty Flask

items.register_vessel("empty_flask", {
	description = "Empty Flask",
	tiles= {"items_empty_flask.png"},
	inventory_image = "items_empty_flask_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "",
	replace_item = "items:flask_with_water"
})

items.register_vessel("flask_with_rose", {
	description = "Flask with Rose",
	tiles= {"items_flask_with_rose.png"},
	inventory_image = "items_flask_with_rose.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "flowers:rose",
	craft = {
		recipe = {
			"items:empty_flask", "flowers:rose",
		}
	}
})

items.register_vessel("flask_with_water", {
	description = "Flask with water",
	tiles= {"items_flask_with_water.png"},
	inventory_image = "items_flask_with_water_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = ""
})

-- Bottle

items.register_vessel("empty_bottle", {
	description = "Empty Bottle",
	tiles= {"items_empty_bottle.png"},
	inventory_image = "items_empty_bottle_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "",
	replace_item = "items:water_bottle"
})

items.register_vessel("water_bottle", {
	description = "Water Bottle",
	tiles= {"items_water_bottle.png"},
	inventory_image = "items_water_bottle_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = ""
})

items.register_vessel("empty_bottle", {
	description = "Empty Bottle",
	tiles= {"items_empty_bottle.png"},
	inventory_image = "items_empty_bottle_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "",
	replace_item = "items:water_bottle"
})


