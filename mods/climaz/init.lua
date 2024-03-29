--
-- Climaz
-- License:GPLv3
--

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

if mg_name ~= "v6" and mg_name ~= "singlenode" and minetest.settings:get_bool("climate_enabled", true) then
	assert(loadfile(modpath .. "/engine.lua"))(modpath)
end
