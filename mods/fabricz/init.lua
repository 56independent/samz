--
-- fabric
-- License:GPLv3
--

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

--
-- Fabric Mod
--

for _, color in ipairs(dyez.colors) do

	local name = modname..":"..color

	minetest.register_craftitem(name, {
		description = S("@1 Cotton Fabric", S(helper.string.uppercase(color))),
		inventory_image = "fabricz_fabric.png^[colorize:"..color..":180",
		groups = {fabric=1}
	})

	minetest.register_craft({
		output = name,
		type = "shaped",
			recipe = {
			{"group:dye,color_" .. color, "farmz:cotton", "farmz:cotton"},
			{"farmz:cotton", "", ""},
			{"", "", ""},
		}
	})
end
