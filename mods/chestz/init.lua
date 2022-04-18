chestz = {}

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

minetest.register_node("chestz:chest", {
	description = S("Chest"),
	inventory_image = "chestz_chest_inv.png",
	tiles ={"chestz_chest_top.png", "chestz_chest_top.png",
		"chestz_chest_side.png", "chestz_chest_side.png",
		"chestz_chest_side.png", "chestz_chest_front.png"},
	paramtype2 = "facedir",
	groups = {dig_immediate=2, choppy=3, vessel=1},
	is_ground_content = false,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]" ..
				"listring[]")
		meta:set_string("infotext", S("Chest"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		return stack:get_count()
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
	end,
})

minetest.register_craft({
	output = "chestz:chest 1",
	type = "shaped",
	recipe = {
		{"group:planks",  "group:planks",
		 "group:planks"},{"group:planks", "", ""},
		{"", "", ""},
	}
})
