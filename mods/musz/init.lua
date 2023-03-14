musz = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

-- Load the files
assert(loadfile(modpath .. "/api.lua"))(modname)
