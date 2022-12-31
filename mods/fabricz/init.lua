--
-- fabric
-- License:GPLv3
--

local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

--
-- Fabric Mod
--

for color, def in pairs(dyez.colors) do

		local color_description, colorstring

	if not def[1] then
		color_description = helper.string.uppercase(color)
	else
		color_description = def[1]
	end

	if not color[2] then
		colorstring = color
	else
		colorstring = color[2]
	end

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
