local S, modname = ...

function itemz.register_vessel(name, def)
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
			if def.replace_item and (pointed_thing.type == "node") then
				local pos = pointed_thing.above
				if pos and helper.node_is_water(pos) then
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

itemz.register_vessel("empty_flask", {
	description = "Empty Flask",
	tiles= {"itemz_empty_flask.png"},
	inventory_image = "itemz_empty_flask_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "",
	replace_item = "itemz:flask_with_water"
})

itemz.register_vessel("flask_with_rose", {
	description = "Flask with Rose",
	tiles= {"itemz_flask_with_rose.png"},
	inventory_image = "itemz_flask_with_rose.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "flowerz:rose",
	craft = {
		recipe = {
			"itemz:empty_flask", "flowerz:rose", "group:water",
		}
	}
})

itemz.register_vessel("flask_with_water", {
	description = "Flask with water",
	tiles= {"itemz_flask_with_water.png"},
	inventory_image = "itemz_flask_with_water_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = ""
})

-- Bottle

itemz.register_vessel("empty_bottle", {
	description = "Empty Bottle",
	tiles= {"itemz_empty_bottle.png"},
	inventory_image = "itemz_empty_bottle_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "",
	replace_item = "itemz:water_bottle"
})

itemz.register_vessel("water_bottle", {
	description = "Water Bottle",
	tiles= {"itemz_water_bottle.png"},
	inventory_image = "itemz_water_bottle_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = ""
})

itemz.register_vessel("empty_bottle", {
	description = "Empty Bottle",
	tiles= {"itemz_empty_bottle.png"},
	inventory_image = "itemz_empty_bottle_inv.png",
	selection_box = {-3/16, -8/16, -3/16, 3/16, 5/16, 3/16},
	drop = "",
	replace_item = "itemz:water_bottle"
})


