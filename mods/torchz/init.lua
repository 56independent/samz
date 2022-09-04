torchz = {}

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

local function on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("torchz:torch 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"sound_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1},
			true
		)
	end
	-- Remove the torch node
	return false
end

minetest.register_node("torchz:torch", {
	description = S("Torch"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, -0.125, 0.0625}, -- NodeBox1
			{-0.1875, -0.5, 0, 0.1875, 0.5, 0}, -- NodeBox2
			{0, -0.5, -0.1875, 0, 0.5, 0.1875}, -- NodeBox4
		}
	},
	inventory_image = "torchz_on_floor.png",
	wield_image = "torchz_on_floor.png",
	tiles = {{
		    name = "torchz_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.0}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1, lighting=1, tool=1},
	drop = "torchz:torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = sound.wood(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("torchz:torchz_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("torchz:torch")
		else
			fakestack:set_name("torchz:torchz_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("torchz:torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_node("torchz:torchz_wall", {
	drawtype = "mesh",
	mesh = "torchz_wall.obj",
	tiles = {{
		name = "torchz_on_floor_animated.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "torchz:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = sound.wood(),
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_craft({
	output = "torchz:torch 4",
	type = "shapeless",
	recipe = {
		"nodez:coal_lump",
		"group:stick",
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "torchz:torch",
	burntime = 4,
})
