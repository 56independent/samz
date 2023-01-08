--
-- bowz
-- License:GPLv3
--

bowz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local S = minetest.get_translator(modname)

--
-- Bowz Mod
--

-- Load the files
assert(loadfile(modpath .. "/api.lua"))(S, modpath)
assert(loadfile(modpath .. "/bows.lua"))(S)
