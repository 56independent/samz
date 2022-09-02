--
-- closetz
-- License:GPLv3
--

closetz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

--
-- Closetz Mod
--

-- Load the files
assert(loadfile(modpath .. "/api/api.lua"))(modpath)
assert(loadfile(modpath .. "/closet.lua"))(S)
