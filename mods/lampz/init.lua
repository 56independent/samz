lampz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

minetest.register_node("lampz:oil_lamp", {
	description = S("Oil Lamp"),
	drawtype = "nodebox",
	inventory_image = "lampz_oil_lamp_inv.png",
	wield_image = "lampz_oil_lamp_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.4375, -0.25, -0.1875, 0.0625, -0.1875}, -- NodeBox1
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}, -- NodeBox2
			{-0.125, -0.375, 0, 0.125, 0.0625, 0}, -- NodeBox3
			{-0.25, -0.4375, 0.1875, -0.1875, 0.0625, 0.25}, -- NodeBox4
			{0.1875, -0.4375, -0.25, 0.25, 0.0625, -0.1875}, -- NodeBox5
			{0.1875, -0.4375, 0.1875, 0.25, 0.0625, 0.25}, -- NodeBox6
			{0, -0.375, 0.125, 0, 0.0625, -0.125}, -- NodeBox7
			{-0.25, 0.0625, -0.25, 0.25, 0.125, 0.25}, -- NodeBox8
			{-0.125, 0.125, -0.125, 0.125, 0.1875, 0.125}, -- NodeBox12
			{-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125}, -- NodeBox13
			{-0.0625, 0.1875, -0.0625, 0.0625, 0.25, 0.0625}, -- NodeBox14
		}
	},
	tiles = {"lampz_oil_lamp_top.png", "lampz_oil_lamp_top.png", {
		    name = "lampz_oil_lamp_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = true,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1, torch=1, lighting=1},
	drop = "lampz:oil_lamp",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-0.25, -0.5, -0.25, 0.25, 0.125, 0.25},
	},
	sounds = sound:metal(),
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
			fakestack:set_name("lampz:oil_lamp_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("lampz:oil_lamp")
		else
			fakestack:set_name("lampz:oil_lamp_wall")
		end
		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("lampz:oil_lamp")

		return itemstack
	end,
})

minetest.register_node("lampz:oil_lamp_ceiling", {
	drawtype = "nodebox",
	node_box = {
        type = "fixed",
		fixed = {
			{-0.25, -0.0625, -0.25, -0.1875, 0.4375, -0.1875}, -- NodeBox1
			{-0.25, 0.4375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox2
			{-0.125, 0.0625, 0, 0.125, 0.375, 0}, -- NodeBox3
			{-0.25, -0.0625, 0.1875, -0.1875, 0.4375, 0.25}, -- NodeBox4
			{0.1875, -0.0625, -0.25, 0.25, 0.4375, -0.1875}, -- NodeBox5
			{0.1875, -0.0625, 0.1875, 0.25, 0.4375, 0.25}, -- NodeBox6
			{0, -0.0625, 0.125, 0, 0.375, -0.125}, -- NodeBox7
			{-0.25, -0.125, -0.25, 0.25, -0.0625, 0.25}, -- NodeBox8
			{-0.125, -0.1875, -0.125, 0.125, -0.125, 0.125}, -- NodeBox12
			{-0.125, 0.375, -0.125, 0.125, 0.4375, 0.125}, -- NodeBox13
			{-0.0625, -0.5, 0, 0.0625, -0.1875, 0}, -- NodeBox14
			{0, -0.5, -0.0625, 0, -0.1875, 0.0625}, -- NodeBox15
		}
    },
	tiles = {"lampz_oil_lamp_top.png", "lampz_oil_lamp_top.png", {
		    name = "lampz_oil_lamp_ceiling_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = true,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, lamp=1, lighting=1},
	drop = "lampz:oil_lamp",
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.25, -0.5, -0.25, 0.25, 0.125, 0.25},
	},
	sounds = sound:metal(),
})

minetest.register_node("lampz:oil_lamp_wall", {
	drawtype = "nodebox",
	node_box = {
        type = "fixed",
		fixed = {
			{-0.25, -0.25, -0.1875, -0.1875, -0.1875, 0.3125}, -- NodeBox1
			{-0.25, -0.25, -0.25, 0.25, 0.25, -0.1875}, -- NodeBox2
			{0, -0.125, -0.125, 0, 0.125, 0.3125}, -- NodeBox3
			{0.1875, -0.25, -0.1875, 0.25, -0.1875, 0.3125}, -- NodeBox4
			{-0.25, 0.1875, -0.1875, -0.1875, 0.25, 0.3125}, -- NodeBox5
			{0.1875, 0.1875, -0.1875, 0.25, 0.25, 0.3125}, -- NodeBox6
			{-0.125, 0, -0.125, 0.125, 0, 0.3125}, -- NodeBox7
			{-0.25, -0.25, 0.3125, 0.25, 0.25, 0.375}, -- NodeBox8
			{-0.125, -0.125, 0.375, 0.125, 0.125, 0.4375}, -- NodeBox12
			{-0.125, -0.125, -0.1875, 0.125, 0.125, -0.125}, -- NodeBox13
			{-0.125, -0.125, -0.3125, 0.125, 0.125, -0.25}, -- NodeBox13
			{-0.0625, -0.0625, 0.4375, 0.0625, 0.0625, 0.5}, -- NodeBox14
			{-0.0625, -0.125, -0.4375, 0.0625, -1.49012e-08, -0.3125}, -- NodeBox15
			{-0.0625, -0.5, -0.5, 0.0625, 0, -0.4375}, -- NodeBox16
		}
    },
	tiles = {
			{name = "lampz_oil_lamp_wall_animated_front.png", animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3
			}},
			{name = "lampz_oil_lamp_wall_animated_front.png^[transformR180", animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3
			}},
			{name = "lampz_oil_lamp_wall_animated.png", animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3
			}},
			{name = "lampz_oil_lamp_wall_animated.png^[transformR180", animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3
			}},
			"lampz_oil_lamp_top.png",
			"lampz_oil_lamp_top.png",
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = true,
	light_source = 12,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, lamp=1, lighting=1},
	drop = "lampz:oil_lamp",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.25, -0.25, -0.25, 0.25, 0.375, 0.25},
	},
	sounds = sound:metal(),
})

minetest.register_craft({
	output = "lampz:oil_lamp",
	recipe = {
		{"nodez:copper_ingot"},
		{"foodz:sunflower_oil"},
		{"itemz:string"}
	}
})
