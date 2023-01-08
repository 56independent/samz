--
-- fabric
-- License:GPLv3
--

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

--
-- Cotton Fabric
--

for color, def in pairs(dyez.colors) do

	--local color_description, colorstring

	--if not def[1] then
		--color_description = helper.string.uppercase(color)
	--else
		--color_description = def[1]
	--end

	--if not color[2] then
		--colorstring = color
	--else
		--colorstring = color[2]
	--end

	local name = modname..":"..color

	minetest.register_craftitem(name, {
		description = S("@1 Cotton Fabric", S(helper.string.uppercase(color))),
		inventory_image = "fabricz_fabric.png^[colorize:"..color..":180",
		groups = {fabric = 1, cloth = 1}
	})

	minetest.register_craft({
		output = name,
		type = "shaped",
		recipe = {
			{"group:dye,color_"..color, "farmz:cotton"},
			{"farmz:cotton", "farmz:cotton"},
		}
	})
end

--Dyeable Fabric Block

minetest.register_node("fabricz:block", {
	description = S("Fabric Block").."\n"..minetest.colorize("yellow", S("Dyeable")),
	tiles = {"fabricz_block.png"},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "colorfacedir",
	palette = "palette8.png",
	sounds = sound.wood(),
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, fabric_block = 1, build = 1, dyeable = 7},
})

minetest.register_craft({
	output = "fabricz:block",
	type = "shaped",
	recipe = {
		{"farmz:cotton", "farmz:cotton"},
		{"farmz:cotton", "farmz:cotton"},
	}
})

--Paper

minetest.register_craftitem("fabricz:paper", {
	description = S("Paper"),
	inventory_image = "fabricz_paper.png",
	groups = {paper = 1, writing = 1}
})

minetest.register_craft({
	output = "fabricz:paper 8",
	type = "shaped",
	recipe = {
		{"group:water", ""},
		{"", "fabricz:block"},
	}
})
